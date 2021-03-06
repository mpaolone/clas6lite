      subroutine bos_ic1

      implicit none
      save
      
#include "gcbank.inc"
#include "bcs.inc"
#include "icgeom.inc"
#include "icsets.inc"
#include "gsimpar.inc"
#include "gsimcontrol.inc"
#include "ffpar_ic.inc"

      integer ndmax
      parameter (ndmax=2000)
      
c      integer itra(20000),lhit(1000),jk,jv,nl,ng,l,ll,juk,ip1,ip2
c      real edep,edep1,size(1000)
c      logical ordered,swap

      integer ntrkmax
      parameter (ntrkmax=2000)

      integer i,idig,nw,mbank,ix,iy
      integer iic 
c      integer nview(ndmax),strip_num(ndmax)
      integer numvs(nvic1), itrack(ntrkmax,ndmax), ntra(ndmax)
      integer numbv(nvic1,ndmax), kdigi(ndic1,ndmax), ndig
      integer ii,iii

      integer ic1id_calo(424)
      data ic1id_calo / 218, 217, 216, 215, 214, 208, 209, 210, 211, 212, 213, 
     +                  207, 206, 205, 204, 203, 202, 195, 196, 197, 198, 199,
     +                  200, 201, 194, 193, 192, 191, 190, 189, 188, 180, 181,
     +                  182, 183, 184, 185, 186, 187, 179, 178, 177, 176, 175,
     +                  174, 173, 172, 163, 164, 165, 166, 167, 168, 169, 170, 
     +                  171, 162, 161, 160, 159, 158, 157, 156, 155, 154, 144, 
     +                  145, 146, 147, 148, 149, 150, 151, 152, 153, 143, 142, 
     +                  141, 140, 139, 138, 137, 136, 135, 134, 123, 124, 125, 
     +                  126, 127, 128, 129, 130, 131, 132, 133, 122, 121, 120, 
     +                  119, 118, 117, 116, 115, 114, 113, 112, 100, 101, 102, 
     +                  103, 104, 105, 106, 107, 108, 109, 110, 111, 99, 98, 
     +                  97, 96, 95, 94, 93, 92, 91, 90, 89, 77, 78, 79, 80, 81,
     +                  82, 83, 84, 85, 86, 87, 88, 76, 75, 74, 73, 72, 71, 70,
     +                  69, 68, 67, 66, 421, 55, 56, 57, 58, 59, 60, 61, 62, 63,
     +                  64, 65, 54, 53, 52, 51, 50, 49, 48, 47, 46, 45, 35, 36,
     +                  37, 38, 39, 40, 41, 42, 43, 44, 34, 33, 32, 31, 30, 29,
     +                  28, 27, 26, 17, 18, 19, 20, 21, 22, 23, 24, 25, 16, 15,
     +                  14, 13, 12, 11, 10, 9, 424, 422, 1, 2, 3, 4, 5, 6, 7, 8,  
     +                  236, 235, 234, 233, 232, 231, 230, 229, 228, 219, 220,
     +                  221, 222, 223, 224, 225, 226, 227, 256, 255, 254, 253,
     +                  252, 251, 250, 249, 248, 247, 237, 238, 239, 240, 241,
     +                  242, 243, 244, 245, 246, 278, 277, 276, 275, 274, 273, 
     +                  272, 271, 270, 269, 268, 423, 257, 258, 259, 260, 261, 
     +                  262, 263, 264, 265, 266, 267, 301, 300, 299, 298, 297,
     +                  296, 295, 294, 293, 292, 291, 279, 280, 281, 282, 283,
     +                  284, 285, 286, 287, 288, 289, 290, 324, 323, 322, 321, 
     +                  320, 319, 318, 317, 316, 315, 314, 302, 303, 304, 305, 
     +                  306, 307, 308, 309, 310, 311, 312, 313, 345, 344, 343, 
     +                  342, 341, 340, 339, 338, 337, 336, 325, 326, 327, 328, 
     +                  329, 330, 331, 332, 333, 334, 335, 364, 363, 362, 361, 
     +                  360, 359, 358, 357, 356, 346, 347, 348, 349, 350, 351, 
     +                  352, 353, 354, 355, 381, 380, 379, 378, 377, 376, 375, 
     +                  374, 365, 366, 367, 368, 369, 370, 371, 372, 373, 396, 
     +                  395, 394, 393, 392, 391, 390, 382, 383, 384, 385, 386, 
     +                  387, 388, 389, 409, 408, 407, 406, 405, 404, 397, 398, 
     +                  399, 400, 401, 402, 403, 420, 419, 418, 417, 416, 410,  
     +                  411, 412, 413, 414, 415 /

      integer ic1id_calo_old(424)
      data ic1id_calo_old / 313, 290, 267, 246, 227, 8, 25, 44, 65, 88, 111,
     +		            335, 312, 289, 266, 245, 226, 7, 24, 43, 64, 87,
     +                      110, 133, 355, 334, 311, 288, 265, 244, 225, 6,
     +                      23, 42, 63, 86, 109, 132, 153, 373, 354, 333, 310,
     +                      287, 264, 243, 224, 5, 22, 41, 62, 85, 108, 131,
     +                      152, 171, 389, 372, 353, 332, 309, 286, 263, 242,
     +                      223, 4, 21, 40, 61, 84, 107, 130, 151, 170, 187,
     +                      403, 388, 371, 352, 331, 308, 285, 262, 241, 222,
     +                      3, 20, 39, 60, 83, 106, 129, 150, 169, 186, 201,
     +                      415, 402, 387, 370, 351, 330, 307, 284, 261, 240,
     +                      221, 2, 19, 38, 59, 82, 105, 128, 149, 168, 185,
     +                      200, 213, 414, 401, 386, 369, 350, 329, 306, 283,
     +                      260, 239, 220, 1, 18, 37, 58, 81, 104, 127, 148, 
     +                      167, 184, 199, 212, 413, 400, 385, 368, 349, 328,
     +                      305, 282, 259, 238, 219, 421, 17, 36, 57, 80, 103,
     +                      126, 147, 166, 183, 198, 211, 412, 399, 384, 367,
     +                      348, 327, 304, 281, 258, 237, 35, 56, 79, 102, 125,
     +                      146, 165, 182, 197, 210, 411, 398, 383, 366, 347,
     +                      326, 303, 280, 257, 55, 78, 101, 124, 145, 164,
     +                      181, 196, 209, 410, 397, 382, 365, 346, 325, 302,
     +                      279, 424, 422, 77, 100, 123, 144, 163, 180, 195,
     +                      208, 416, 404, 390, 374, 356, 336, 314, 291, 268,
     +                      66, 89, 112, 134, 154, 172, 188, 202, 214, 417,
     +                      405, 391, 375, 357, 337, 315, 292, 269, 247, 45,
     +                      67, 90, 113, 135, 155, 173, 189, 203, 215, 418,
     +                      406, 392, 376, 358, 338, 316, 293, 270, 248, 228,
     +                      423, 26, 46, 68, 91, 114, 136, 156, 174, 190, 204, 
     +                      216, 419, 407, 393, 377, 359, 339, 317, 294, 271,
     +                      249, 229, 9, 27, 47, 69, 92, 115, 137, 157, 175,
     +                      191, 205, 217, 420, 408, 394, 378, 360, 340, 318,
     +                      295, 272, 250, 230, 10, 28, 48, 70, 93, 116, 138,
     +                      158, 176, 192, 206, 218, 409, 395, 379, 361, 341,
     +                      319, 296, 273, 251, 231, 11, 29, 49, 71, 94, 117,
     +                      139, 159, 177, 193, 207, 396, 380, 362, 342, 320,
     +                      297, 274, 252, 232, 12, 30, 50, 72, 95, 118, 140,
     +                      160, 178, 194, 381, 363, 343, 321, 298, 275, 253,
     +                      233, 13, 31, 51, 73, 96, 119, 141, 161, 179, 364,
     +                      344, 322, 299, 276, 254, 234, 14, 32, 52, 74, 97,
     +                      120, 142, 162, 345, 323, 300, 277, 255, 235, 15,
     +                      33, 53, 75, 98, 121, 143, 324, 301, 278, 256, 236, 
     +                      16, 34, 54, 76, 99, 122 /
		       
      integer numhexa_calo(424)
      data numhexa_calo / Z'1711', Z'1710', Z'170F', Z'170E', Z'170D', Z'170C',
     +                    Z'170B', Z'170A', Z'1709', Z'1708', Z'1707', Z'1612',
     +                    Z'1611', Z'1610', Z'160F', Z'160E', Z'160D', Z'160C',
     +                    Z'160B', Z'160A', Z'1609', Z'1608', Z'1607', Z'1606', 
     +                    Z'1513', Z'1512', Z'1511', Z'1510', Z'150F', Z'150E',
     +                    Z'150D', Z'150C', Z'150B', Z'150A', Z'1509', Z'1508',
     +                    Z'1507', Z'1506', Z'1505', Z'1414', Z'1413', Z'1412',
     +                    Z'1411', Z'1410', Z'140F', Z'140E', Z'140D', Z'140C',
     +                    Z'140B', Z'140A', Z'1409', Z'1408', Z'1407', Z'1406',
     +                    Z'1405', Z'1404', Z'1315', Z'1314', Z'1313', Z'1312',
     +                    Z'1311', Z'1310', Z'130F', Z'130E', Z'130D', Z'130C',
     +                    Z'130B', Z'130A', Z'1309', Z'1308', Z'1307', Z'1306',
     +                    Z'1305', Z'1304', Z'1303', Z'1216', Z'1215', Z'1214',
     +                    Z'1213', Z'1212', Z'1211', Z'1210', Z'120F', Z'120E',
     +                    Z'120D', Z'120C', Z'120B', Z'120A', Z'1209', Z'1208',
     +                    Z'1207', Z'1206', Z'1205', Z'1204', Z'1203', Z'1202',
     +                    Z'1117', Z'1116', Z'1115', Z'1114', Z'1113', Z'1112',
     +                    Z'1111', Z'1110', Z'110F', Z'110E', Z'110D', Z'110C',
     +                    Z'110B', Z'110A', Z'1109', Z'1108', Z'1107', Z'1106',
     +                    Z'1105', Z'1104', Z'1103', Z'1102', Z'1101', Z'1017',
     +                    Z'1016', Z'1015', Z'1014', Z'1013', Z'1012', Z'1011',
     +                    Z'1010', Z'100F', Z'100E', Z'100D', Z'100C', Z'100B',
     +                    Z'100A', Z'1009', Z'1008', Z'1007', Z'1006', Z'1005',
     +                    Z'1004', Z'1003', Z'1002', Z'1001', Z'0F17', Z'0F16',
     +                    Z'0F15', Z'0F14', Z'0F13', Z'0F12', Z'0F11', Z'0F10',
     +                    Z'0F0F', Z'0F0E', Z'0F0D', Z'0F0C', Z'0F0B', Z'0F0A',
     +                    Z'0F09', Z'0F08', Z'0F07', Z'0F06', Z'0F05', Z'0F04',
     +                    Z'0F03', Z'0F02', Z'0F01', Z'0E17', Z'0E16', Z'0E15',
     +                    Z'0E14', Z'0E13', Z'0E12', Z'0E11', Z'0E10', Z'0E0F',
     +                    Z'0E0E', Z'0E0A', Z'0E09', Z'0E08', Z'0E07', Z'0E06',
     +                    Z'0E05', Z'0E04', Z'0E03', Z'0E02', Z'0E01', Z'0D17', 
     +                    Z'0D16', Z'0D15', Z'0D14', Z'0D13', Z'0D12', Z'0D11',
     +                    Z'0D10', Z'0D0F', Z'0D09', Z'0D08', Z'0D07', Z'0D06', 
     +                    Z'0D05', Z'0D04', Z'0D03', Z'0D02', Z'0D01', Z'0C17', 
     +                    Z'0C16', Z'0C15', Z'0C14', Z'0C13', Z'0C12', Z'0C11',
     +                    Z'0C10', Z'0C0F', Z'0C09', Z'0C08', Z'0C07', Z'0C06',
     +                    Z'0C05', Z'0C04', Z'0C03', Z'0C02', Z'0C01', Z'0B17',
     +                    Z'0B16', Z'0B15', Z'0B14', Z'0B13', Z'0B12', Z'0B11',
     +                    Z'0B10', Z'0B0F', Z'0B09', Z'0B08', Z'0B07', Z'0B06',
     +                    Z'0B05', Z'0B04', Z'0B03', Z'0B02', Z'0B01', Z'0A17',
     +                    Z'0A16', Z'0A15', Z'0A14', Z'0A13', Z'0A12', Z'0A11',
     +                    Z'0A10', Z'0A0F', Z'0A0E', Z'0A0A', Z'0A09', Z'0A08',
     +                    Z'0A07', Z'0A06', Z'0A05', Z'0A04', Z'0A03', Z'0A02',
     +                    Z'0A01', Z'0917', Z'0916', Z'0915', Z'0914', Z'0913',
     +                    Z'0912', Z'0911', Z'0910', Z'090F', Z'090E', Z'090D',
     +                    Z'090C', Z'090B', Z'090A', Z'0909', Z'0908', Z'0907',
     +                    Z'0906', Z'0905', Z'0904', Z'0903', Z'0902', Z'0901',
     +                    Z'0817', Z'0816', Z'0815', Z'0814', Z'0813', Z'0812',
     +                    Z'0811', Z'0810', Z'080F', Z'080E', Z'080D', Z'080C',
     +                    Z'080B', Z'080A', Z'0809', Z'0808', Z'0807', Z'0806',
     +                    Z'0805', Z'0804', Z'0803', Z'0802', Z'0801', Z'0717',
     +                    Z'0716', Z'0715', Z'0714', Z'0713', Z'0712', Z'0711', 
     +                    Z'0710', Z'070F', Z'070E', Z'070D', Z'070C', Z'070B',
     +                    Z'070A', Z'0709', Z'0708', Z'0707', Z'0706', Z'0705',
     +                    Z'0704', Z'0703', Z'0702', Z'0701', Z'0616', Z'0615',
     +                    Z'0614', Z'0613', Z'0612', Z'0611', Z'0610', Z'060F',
     +                    Z'060E', Z'060D', Z'060C', Z'060B', Z'060A', Z'0609',
     +                    Z'0608', Z'0607', Z'0606', Z'0605', Z'0604', Z'0603',
     +                    Z'0602', Z'0515', Z'0514', Z'0513', Z'0512', Z'0511',
     +                    Z'0510', Z'050F', Z'050E', Z'050D', Z'050C', Z'050B',
     +                    Z'050A', Z'0509', Z'0508', Z'0507', Z'0506', Z'0505',
     +                    Z'0504', Z'0503', Z'0414', Z'0413', Z'0412', Z'0411',
     +                    Z'0410', Z'040F', Z'040E', Z'040D', Z'040C', Z'040B',
     +                    Z'040A', Z'0409', Z'0408', Z'0407', Z'0406', Z'0405',
     +                    Z'0404', Z'0313', Z'0312', Z'0311', Z'0310', Z'030F',
     +                    Z'030E', Z'030D', Z'030C', Z'030B', Z'030A', Z'0309', 
     +                    Z'0308', Z'0307', Z'0306', Z'0305', Z'0212', Z'0211',
     +                    Z'0210', Z'020F', Z'020E', Z'020D', Z'020C', Z'020B',
     +                    Z'020A', Z'0209', Z'0208', Z'0207', Z'0206', Z'0111',
     +                    Z'0110', Z'010F', Z'010E', Z'010D', Z'010C', Z'010B',
     +                    Z'010A', Z'0109', Z'0108', Z'0107' /


      integer ic1id_proto(100)
      data ic1id_proto / 20, 19, 18, 17, 16, 11, 12, 13, 14, 15,     
     +                   10, 9, 8, 7, 6, 1, 2, 3, 4, 5, 30, 29,
     +                   28, 27, 26, 21, 22, 23, 24, 25, 40, 39,
     +                   38, 37, 36, 31, 32, 33, 34, 35, 55, 54,
     +                   53, 52, 51, 50, 49, 41, 42, 43, 44, 45,
     +                   46, 47, 48, 70, 69, 68, 67, 66, 65, 64, 
     +                   56, 57, 58, 59, 60, 61, 62, 63, 85, 84, 
     +                   83, 82, 81, 80, 79, 71, 72, 73, 74, 75,
     +                   76, 77, 78, 100, 99, 98, 97, 96, 95, 94,
     +                   86, 87, 88, 89, 90, 91, 92, 93 / 

      integer numhexa_proto(100)        
      data numhexa_proto / Z'0D13', Z'0D12', Z'0D11', Z'0D10', Z'0D0F',
     +                     Z'0D09', Z'0D08', Z'0D07', Z'0D06', Z'0D05',
     +                     Z'0C13', Z'0C12', Z'0C11', Z'0C10', Z'0C0F',
     +                     Z'0C09', Z'0C08', Z'0C07', Z'0C06', Z'0C05',
     +                     Z'0B13', Z'0B12', Z'0B11', Z'0B10', Z'0B0F',
     +                     Z'0B09', Z'0B08', Z'0B07', Z'0B06', Z'0B05',
     +                     Z'0A13', Z'0A12', Z'0A11', Z'0A10', Z'0A0F',
     +                     Z'0A09', Z'0A08', Z'0A07', Z'0A06', Z'0A05',
     +                     Z'0913', Z'0912', Z'0911', Z'0910', Z'090F',
     +                     Z'090E', Z'090D', Z'090C', Z'090B', Z'090A',
     +                     Z'0909', Z'0908', Z'0907', Z'0906', Z'0905',
     +                     Z'0813', Z'0812', Z'0811', Z'0810', Z'080F', 
     +                     Z'080E', Z'080D', Z'080C', Z'080B', Z'080A',
     +                     Z'0809', Z'0808', Z'0807', Z'0806', Z'0805',
     +                     Z'0713', Z'0712', Z'0711', Z'0710', Z'070F',
     +                     Z'070E', Z'070D', Z'070C', Z'070B', Z'070A',
     +                     Z'0709', Z'0708', Z'0707', Z'0706', Z'0705',
     +                     Z'0613', Z'0612', Z'0611', Z'0610', Z'060F',
     +                     Z'060E', Z'060D', Z'060C', Z'060B', Z'060A',
     +                     Z'0609', Z'0608', Z'0607', Z'0606', Z'0605' /

                           
c     kdigi(1,) - i_adc 
c     kdigi(2,) - i_tdc 

c  fill IC bos banks from digis

      if(.not.nodata(ic))then
         call vzero(numvs,nvic1)
         
         idig=0
         call gfdigi('IC  ','IC1 ',ntrkmax,nvic1,ndic1,(ndmax-idig),numvs
     $           ,itrack(1,idig+1),ntra(idig+1),numbv(1,idig+1),kdigi(1
     $           ,idig+1),ndig)
     
c         print *, 'IC1-BOS',ntrkmax,ntra(idig+1),ndig,kdigi(1,1),
c     +        kdigi(2,1),ndig
         idig = idig+ndig
         
c  write digis to bos banks by sector
         iic=mbank(iw,'IC  ',0,3,idig)
         iic=iic*2      !because of integer*2 words
         
         do i=1,idig
            
            if (ic_mod.eq.2) then
               do ii=1,424
                  if (ic1id_calo(ii).eq.numbv(1,i)) then
                     ix=numhexa_calo(ii)
                     goto 1
                  endif
               enddo
            elseif (ic_mod.eq.3) then
               do ii=1,100
                  if (ic1id_proto(ii).eq.numbv(1,i)) then
                     ix=numhexa_proto(ii)
                     goto 1
                  endif
               enddo               
            else
            endif
 1             continue
            iw16(iic+1)=ix          !id
            iw16(iic+2)=kdigi(2,i)  !tdc
            iw16(iic+3)=kdigi(1,i)  !adc
            iic=iic+3
c           print *, 'IC1-BOS: i,x,ADC,TDC',ix,kdigi(1,i),kdigi(2,i) 

c           print *,'iw16(iic+1)=ix  !id',iw16(iic+1)
c           print *,'iw16(iic+2)=kdigi(2,i)  !tdc',iw16(iic+2)
c           print *,'iw16(iic+3)=kdigi(1,i)  !adc',iw16(iic+3)
         enddo
      endif
      
      return
      end

