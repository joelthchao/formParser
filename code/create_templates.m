function create_templates()
%CREATE TEMPLATES
%Letter
A=imread('letters_numbers\A.bmp');B=imread('letters_numbers\B.bmp');
C=imread('letters_numbers\C.bmp');D=imread('letters_numbers\D.bmp');
E=imread('letters_numbers\E.bmp');F=imread('letters_numbers\F.bmp');
G=imread('letters_numbers\G.bmp');H=imread('letters_numbers\H.bmp');
I=imread('letters_numbers\I.bmp');J=imread('letters_numbers\J.bmp');
K=imread('letters_numbers\K.bmp');L=imread('letters_numbers\L.bmp');
M=imread('letters_numbers\M.bmp');N=imread('letters_numbers\N.bmp');
O=imread('letters_numbers\O.bmp');P=imread('letters_numbers\P.bmp');
Q=imread('letters_numbers\Q.bmp');R=imread('letters_numbers\R.bmp');
S=imread('letters_numbers\S.bmp');T=imread('letters_numbers\T.bmp');
U=imread('letters_numbers\U.bmp');V=imread('letters_numbers\V.bmp');
W=imread('letters_numbers\W.bmp');X=imread('letters_numbers\X.bmp');
Y=imread('letters_numbers\Y.bmp');Z=imread('letters_numbers\Z.bmp');
%Number
one=imread('letters_numbers\1.bmp');  two=imread('letters_numbers\2.bmp');
three=imread('letters_numbers\3.bmp');four=imread('letters_numbers\4.bmp');
five=imread('letters_numbers\5.bmp'); six=imread('letters_numbers\6.bmp');
seven=imread('letters_numbers\7.bmp');eight=imread('letters_numbers\8.bmp');
nine=imread('letters_numbers\9.bmp'); zero=imread('letters_numbers\0.bmp');
%Add Number
one2=imread('letters_numbers\1_2.bmp'); one3=imread('letters_numbers\1_3.bmp');
four2=imread('letters_numbers\4_2.bmp'); six2=imread('letters_numbers\6_2.bmp');
eight2=imread('letters_numbers\8_2.bmp');
%small letter
sa=imread('letters_numbers\sa.bmp');sb=imread('letters_numbers\sb.bmp');
sc=imread('letters_numbers\sc.bmp');sd=imread('letters_numbers\sd.bmp');
se=imread('letters_numbers\se.bmp');sf=imread('letters_numbers\sf.bmp');
sg=imread('letters_numbers\sg.bmp');sh=imread('letters_numbers\sh.bmp');
si=imread('letters_numbers\si.bmp');sj=imread('letters_numbers\sj.bmp');
sk=imread('letters_numbers\sk.bmp');sm=imread('letters_numbers\sm.bmp');
sn=imread('letters_numbers\sn.bmp');sp=imread('letters_numbers\sp.bmp');
sq=imread('letters_numbers\sq.bmp');sr=imread('letters_numbers\sr.bmp');
st=imread('letters_numbers\st.bmp');su=imread('letters_numbers\su.bmp');
sy=imread('letters_numbers\sy.bmp');

%*-*-*-*-*-*-*-*-*-*-*-
%26
letter=[A B C D E F G H I J K L M...
    N O P Q R S T U V W X Y Z];
%10
number=[one two three four five...
    six seven eight nine zero];
%24
add_char=[one2 one3 four2 six2 eight2...
    sa sb sc sd se sf sg sh si sj...
    sk sm sn sp sq sr st su sy];
character=[letter number add_char];
templates=mat2cell(character,42,[24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 ...
    ]);
save ('templates','templates')
end