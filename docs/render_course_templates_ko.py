from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

ROOT=Path(__file__).resolve().parents[1]
DOCS=ROOT/'docs'; ASSET=DOCS/'screenshots'/'journey'
REG=Path(r'C:\Windows\Fonts\malgun.ttf'); BOLD=Path(r'C:\Windows\Fonts\malgunbd.ttf')
BG='#F7F8FB'; WHITE='#FFFFFF'; NAVY='#172544'; BLUE='#2767D7'; TEAL='#149F93'; ORANGE='#D97C2B'; MUTED='#66738A'; LINE='#DCE2EC'
def f(n,b=False): return ImageFont.truetype(str(BOLD if b else REG),n)
def roundbox(d,box,fill=WHITE,outline=LINE,r=14,w=2): d.rounded_rectangle(box,radius=r,fill=fill,outline=outline,width=w)
def wrap(d,s,font,maxw):
    lines=[]
    for paragraph in s.split('\n'):
        words=paragraph.split(); line=''
        for word in words:
            trial=(line+' '+word).strip()
            if d.textbbox((0,0),trial,font=font)[2] <= maxw: line=trial
            else:
                if line: lines.append(line)
                line=word
        if line: lines.append(line)
        if not words: lines.append('')
    return lines
def para(d,s,x,y,font,color,maxw,maxrows=5,leading=5):
    lines=wrap(d,s,font,maxw)
    if len(lines)>maxrows: lines=lines[:maxrows]
    for line in lines:
        d.text((x,y),line,font=font,fill=color); y+=font.size+leading
    return y
def paste_phone(canvas,path,box):
    x,y,w,h=box; im=Image.open(path).convert('RGB'); im.thumbnail((w,h),Image.Resampling.LANCZOS)
    canvas.paste(im,(x+(w-im.width)//2,y+(h-im.height)//2))

# QANDA-inspired review/emotion journey: curves are qualitative review signals, not user scores.
W,H=3000,1690
im=Image.new('RGB',(W,H),BG); d=ImageDraw.Draw(im)
d.text((58,30),'사용자 여정 · WALLET 현재 버전',font=f(27,True),fill=BLUE)
d.text((58,76),'Wallet iOS 5.7.5 — 다중 통화 현금 흐름을 계획하는 여정',font=f(43,True),fill=NAVY)
d.text((60,137),'여정 목표: KRW/VND 잔액과 반복 수입·지출을 확인해 가까운 시점의 현금 흐름을 이해한다.',font=f(21),fill=MUTED)
roundbox(d,(2325,28,2940,125),fill='#FFF4E8',outline='#EED6BE')
d.text((2352,47),'분석 대상: Wallet',font=f(22,True),fill=ORANGE)
d.text((2352,82),'Finaci는 v2 확장 기회',font=f(18),fill='#89664A')
d.text((60,190),'리뷰에 나타난 긍정·부정 경험의 정성 요약 · 감정 점수나 사용성 측정값이 아님',font=f(17,True),fill=MUTED)
# Evidence signal graph, without numeric scale. Missing review evidence stays blank.
left=270; right=2840; plot_top=250; plot_bottom=610
for y,label in [(280,'긍정 경험'),(430,'혼합 / 개선 요청'),(580,'불편 경험')]:
    d.line((left,y,right,y),fill='#E3E8F0',width=2); d.text((60,y-12),label,font=f(16,True),fill=MUTED)
margin=58; gap=18; cw=466; centers=[margin+i*(cw+gap)+cw//2 for i in range(6)]
for i,x in enumerate(centers):
    d.rounded_rectangle((x-20,220,x+20,260),radius=11,fill=ORANGE if i==1 else BLUE)
    d.text((x-6,226),str(i+1),font=f(21,True),fill=WHITE)
# Positive line only connects consecutive reviewed steps 3-5. Step 1 is its own signal.
d.ellipse((centers[0]-11,280-11,centers[0]+11,280+11),fill=WHITE,outline=BLUE,width=5)
positive=[(centers[2],360),(centers[3],400),(centers[4],315)]
d.line(positive,fill=BLUE,width=6,joint='curve')
for x,y in positive: d.ellipse((x-10,y-10,x+10,y+10),fill=WHITE,outline=BLUE,width=5)
negative=[(centers[1],580),(centers[2],490),(centers[3],500),(centers[4],485)]
d.line(negative,fill=ORANGE,width=6,joint='curve')
for x,y in negative: d.ellipse((x-10,y-10,x+10,y+10),fill=WHITE,outline=ORANGE,width=5)
# Stage 6 is deliberately an evidence gap; no interpolated review sentiment.
d.ellipse((centers[5]-11,420-11,centers[5]+11,420+11),fill='#EFF1F5',outline=MUTED,width=3)
d.text((centers[5]-76,447),'직접 리뷰 없음',font=f(15,True),fill=MUTED)

review_cards=[
 ('1 · 잔액 확인','R12 · 4★ · 2024-03-24\nDashboard/Statistics 긍정 평가\nR03 · 5★는 월초 잔액 표시 요청',BLUE),
 ('2 · 통화·계좌 / Sync','R06 · 1★ · R09 · 1★\nR10 · 2★ · R18 · 1★ · R20 · 2★\n연결·중복·잔액 관련 과거 보고',ORANGE),
 ('3 · Quick Add','R11 · 5★ · 2023-03-06\n차트는 긍정, 수기 입력은 오래 걸림\nR13 · Android 리뷰는 별도 신호',BLUE),
 ('4 · Planned Payments','R05 · 3★ · 2026-05-13\n예정 결제 알림 관련 의견\nR19 · 5★ · 날짜별 흐름 보기 요청',ORANGE),
 ('5 · Budgets','R16 · 5★ · 유연성 긍정\nR15 · 5★ · 일부 작업이 번거롭다는 의견\n서로 다른 지역·플랫폼',BLUE),
 ('6 · Statistics / Outlook','R01–R20: 직접 Outlook 리뷰 없음\n개인 경험: Planned Payments를\nOutlook에서 보려면 재입력 필요',TEAL)]
card_y=660; card_h=215
for i,(title,body,accent) in enumerate(review_cards):
    x=margin+i*(cw+gap); cx=x+cw//2
    # The connectors attach every review card to its journey stage.
    node_y=([280] if i==0 else [580] if i==1 else [360,490] if i==2 else [400,500] if i==3 else [315,485] if i==4 else [420])
    for py in node_y: d.line((cx,py+12,cx,card_y),fill=accent,width=2)
    roundbox(d,(x,card_y,x+cw,card_y+card_h),fill=WHITE,outline=LINE,r=14,w=2)
    d.rounded_rectangle((x,card_y,x+cw,card_y+9),radius=5,fill=accent)
    d.text((x+17,card_y+17),title,font=f(24,True),fill=NAVY)
    para(d,body,x+17,card_y+59,f(24),MUTED,cw-34,4,leading=6)
# Source screenshots aligned to the same six stages.
d.text((58,892),'실제 Wallet 화면 · 단계별 캡처',font=f(23,True),fill=BLUE)
screens=[
 ('wallet-dashboard-redacted.jpg','1 · Dashboard'),('wallet-bank-list.jpg','2 · Bank Sync'),('wallet-quick-add.jpg','3 · Quick Add'),
 ('wallet-planned-payments-redacted.jpg','4 · Planned Payments'),('wallet-budget-redacted.jpg','5 · Budgets'),('wallet-statistics-redacted.jpg','6 · Statistics / Outlook')]
thumb_y=930; thumb_h=520
for i,(name,label) in enumerate(screens):
    x=margin+i*(cw+gap)
    roundbox(d,(x,thumb_y,x+cw,thumb_y+thumb_h),fill=WHITE,outline=LINE,r=12,w=2)
    d.text((x+15,thumb_y+12),label,font=f(20,True),fill=NAVY)
    roundbox(d,(x+13,thumb_y+47,x+cw-13,thumb_y+thumb_h-13),fill='#101216',outline='#101216',r=8,w=1)
    paste_phone(im,ASSET/name,(x+102,thumb_y+52,260,thumb_h-65))
d.text((60,1510),'AI 감정 추정: 0 / -1 / 0 / 0 / -1 / -2 · 사용자가 검토 후 채택한 추정치이며 직접 평정은 아닙니다.',font=f(19,True),fill=ORANGE)
d.text((60,1550),'리뷰 요약은 원문 인용이 아닙니다. 날짜·별점·store·원문은 docs/wallet-review-notes.md에서 확인하세요.',font=f(18),fill=MUTED)
d.text((60,1590),'기본 로그인 후 흐름을 기준으로 재구성했습니다. 각 화면은 별도로 확인했으며 연속 세션 기록은 아닙니다.',font=f(18),fill=MUTED)
im.save(DOCS/'wallet-user-journey-board-ko.png',optimize=True)

# Compact classroom Fishbone + 5 Whys. Six branches converge on one observed effect.
W,H=3000,1180
fish=Image.new('RGB',(W,H),BG); d=ImageDraw.Draw(fish)
d.text((58,30),'문제 분석 · FISHBONE + 5 WHY',font=f(27,True),fill=BLUE)
d.text((58,76),'Planned Payments를 Outlook에서 보려면 다시 입력해야 한다',font=f(39,True),fill=NAVY)
d.text((60,137),'Wallet iOS 5.7.5의 개인 사용 경험 · 화면/리뷰만으로 시스템 내부 원인은 단정하지 않음',font=f(20),fill=MUTED)
# Central spine and six short cause cards.
sy=475; sx=95; head_x=2390
d.line((sx,sy,head_x,sy),fill=NAVY,width=8)
d.line((sx,sy,45,sy-42),fill=NAVY,width=6); d.line((sx,sy,45,sy+42),fill=NAVY,width=6)
causes=[
 ('모바일 UX','잔액·예정·전망이 다른 화면에 있음\n비교할 때 맥락 전환 가능','캡처 기반 가설',370,False),
 ('사용성','두 기능이 서로 다른 화면에 있어\n사용자가 연결하기 어렵다고 보고','직접 경험',930,False),
 ('데이터','잔액·반복 항목·날짜·통화/환율\n가정이 전망에 필요','관찰 + 설계 조건',1490,False),
 ('API','한국에서 보인 연결 선택지 3개\n국가별 제휴 범위 차이 가능','관찰; 원인 미확정',370,True),
 ('네트워크','Sync 오류 리뷰는 과거·다지역\n현재 iOS에서 재현 안 됨','R06/R09/R10/R18/R20',930,True),
 ('프로세스','Planned Payments를 Outlook에 다시 입력\n월 budget 시작일 조정 불가 경험','직접 경험',1490,True)]
for title,body,evidence,cx,lower in causes:
    x=cx-220; y=220 if not lower else 545; w=440; h=180
    roundbox(d,(x,y,x+w,y+h),fill=WHITE,outline=LINE,r=13,w=2)
    d.rounded_rectangle((x,y,x+w,y+8),radius=5,fill=TEAL if lower else BLUE)
    d.text((x+17,y+17),title,font=f(23,True),fill=TEAL if lower else BLUE)
    para(d,body,x+17,y+55,f(22),NAVY,w-34,maxrows=4,leading=5)
    d.text((x+17,y+h-28),evidence,font=f(14,True),fill=MUTED)
    branch=(cx+185,sy)
    target=(cx-65,y+h if not lower else y)
    d.line((branch[0],branch[1],target[0],target[1]),fill=TEAL if lower else BLUE,width=5)
    d.ellipse((branch[0]-8,sy-8,branch[0]+8,sy+8),fill=WHITE,outline=ORANGE,width=4)
# Fish head: single user-facing effect.
roundbox(d,(head_x,sy-82,2940,sy+82),fill='#FFF4E8',outline='#E1A06C',r=24,w=4)
d.text((head_x+24,sy-57),'결과 (머리)',font=f(21,True),fill=ORANGE)
para(d,'예정 항목을 Outlook에서 재입력',head_x+24,sy-18,f(22,True),NAVY,470,maxrows=3,leading=5)
# Priority statement is a compact bridge from diagnosis to screen planning.
roundbox(d,(58,745,2940,803),fill='#EAF1FF',outline='#CAD9F4',r=10,w=1)
d.text((78,763),'우선순위 1',font=f(20,True),fill=BLUE)
d.text((250,763),'등록된 Planned Payments를 Outlook에 다시 입력하지 않고 재사용하도록 돕기',font=f(20,True),fill=NAVY)
d.text((60,820),'5 WHY · Q1–2 개인 경험 · Q3–5 UX 가설 · 내부 기술 원인은 미확인',font=f(21,True),fill=MUTED)
why=[
 ('Q1 · 왜?','목표일 잔액을 왜 이해하기 어렵나?','알려진 수입·지출을 Outlook과 직접 연결해야 함. 개인 사용 경험.'),
 ('Q2 · 왜?','왜 알려진 항목도 직접 연결하나?','Planned Payments 항목을 Outlook에서 다시 입력해야 했다고 보고함.'),
 ('Q3 · 왜?','왜 기존 항목 재사용을 알기 어렵나?','출처·날짜·통화·반영 여부의 연결이 사용자에게 뚜렷하지 않음. UX 가설.'),
 ('Q4 · 왜?','왜 연결이 끊겨 보이나?','기록과 전망을 별도 작업으로 느끼며 계획을 끝내는 연결 단계가 부족함. 가설.'),
 ('Q5 → 근본 원인 후보','과업 관점의 근본 원인은?','입력한 항목에서 전망까지 추적 가능한 연결 경험이 부족함. 내부 원인 미확인.')]

wy=860; ww=548; gap=20; wh=235
for i,(label,q,a) in enumerate(why):
    x=58+i*(ww+gap); root=i==4
    roundbox(d,(x,wy,x+ww,wy+wh),fill='#FFF4E8' if root else WHITE,outline='#E1A06C' if root else LINE,r=13,w=2)
    d.text((x+17,wy+15),label,font=f(19,True),fill=ORANGE if root else BLUE)
    para(d,q,x+17,wy+52,f(23,True),NAVY,ww-34,maxrows=2,leading=5)
    d.line((x+17,wy+108,x+ww-17,wy+108),fill=LINE,width=2)
    para(d,a,x+17,wy+122,f(20),MUTED,ww-34,maxrows=4,leading=5)
d.text((60,1120),'Sync는 리뷰 최저점, Outlook은 개인 과업 최저점. 직접 경험과 UI 개선 범위를 근거로 Outlook을 우선했습니다.',font=f(18),fill=MUTED)
fish.save(DOCS/'wallet-fishbone-5why-board-ko.png',optimize=True)
print('Updated QANDA-style Journey and compact Fishbone boards.')

