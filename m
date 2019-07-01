Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2541150B06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 14:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfFXMov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 08:44:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39100 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:44:51 -0400
Received: by mail-io1-f67.google.com with SMTP id r185so385081iod.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Yw5SsYvMRwwTlcsQIVd3tjtioKZQflo8z51IVyqFtJtgQCFqYdHvEk8njRk/ttGIVh
         /MKsIHI/X2n4UFGuLgR7bMsGxZef9SgKISEci5DnRoQdHrCyYxChb8wg33ui/8Is0S2q
         tVcpWm//CtOzufCCEzeDyCnYwfeMmnTjrs2DbVB0wrUni1unleSjYASEFxr81PBQTLrc
         gi5CL2hScNYS4m1rjxF0ibKM6M0ld99BhojS9lVhDOREXiw9BIAncG36mwQK4voWGu1b
         FF9QJGv1ScsMLM81dKbur6B3LtdFO9d2nH6u2rVJe/DfIDvkxrUrT9ZuhnIMrscstIBq
         jJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ntjqmE1OVvLPXzLmPC8QjH2BK89p+RwFBtkPgKXLdpNept5ss8U7z/1V/LkiEGV+lm
         /0UMs/ciRjSUVvf2971W6edJZVqjwQuaSXpSWw6T8RDeiMSh6AfWw6suykcIK24Jq7xZ
         q4pM3R7Ukt2XUbWMC+l+Sh3Aehk82hOeOtF4TbNiPhdvqkSeKNZ58Al3SY4uDVU6uuqF
         8+h8oHvdQXyXvbJ3iMe0YzqCX//fTpjDcxKKz4tTcug633scd5peD0TxarMA8xKXXhDM
         Z5IL8lIAez3Fycb80ZgLgeIJmSvCF0WR4Mfyad9QRgNMelAr+XaBIuUVTjOIxE2XQSCF
         nPHg==
X-Gm-Message-State: APjAAAU+awJpZnZKsJJTwi8FQPkSjRlslO0sSrU5sfLzauooMPF+u3JR
        xo+OgOo1Bd648PokEWmTsVMtWSDK1PpNgsjHeUY=
X-Google-Smtp-Source: APXvYqw2HtXxQ30FsZT67M7nGCM2GhvxSEnsDZ10zarAOmF5hAYGpPHmVuMral99UezYTHpFPF4INnwSRJbxxeYddXM=
X-Received: by 2002:a02:ce52:: with SMTP id y18mr23793494jar.78.1561380290471;
 Mon, 24 Jun 2019 05:44:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:600e:0:0:0:0:0 with HTTP; Mon, 24 Jun 2019 05:44:49
 -0700 (PDT)
In-Reply-To: <CANu4p=a5h4vkdGfthTbA8FydZ=uKMrMV16U0P7tjYuL58BOysQ@mail.gmail.com>
References: <CANu4p=YM6ix-51RytrNU2i+33-CVQzaYSCAGzr=tk3-hENcA=A@mail.gmail.com>
 <CANu4p=YP-Gs-ono+UrYJpmOgtPPYUwahToq2Wy+jfW0L0N3jew@mail.gmail.com>
 <CANu4p=Yx-kRVue_+b=FR=n8NAgUW_jsiWrz0AcQmXV833EXzBw@mail.gmail.com>
 <CANu4p=bzT6jyNno7eE+N+rW-Ag-0m73UAsPxwPtisXZUNuCOGQ@mail.gmail.com>
 <CANu4p=bO1gCsAXKOoRKvUEcBY1n8DHi=BmG0jE=ysbv2+BbmHw@mail.gmail.com>
 <CANu4p=ZNXSwyT3M9yejxSLRWhzLRrT=frkG7WN61gabCMVxB3g@mail.gmail.com>
 <CANu4p=bNEz+4uMtLPCxLcxZZ6e38cVE6B5tnkY1kAt3Tp=htmA@mail.gmail.com>
 <CANu4p=YgGfTfXz=jVrkOLrvNQHbx90+JsJrK8cN34O-k2y2HrQ@mail.gmail.com>
 <CANu4p=a0dgXAamDJeVCFNMwU1CKTtJrpx6tJhJOV53QF6B_W-Q@mail.gmail.com>
 <CANu4p=awzq9LodM8F_4s3KsNa77W+WVswFRVxLpacQ57a3-uAg@mail.gmail.com>
 <CANu4p=Y0kHWb+6sARBCo9OUa7=gcL6wMj8g5zjAdDHztL1qXMQ@mail.gmail.com>
 <CANu4p=YDYvw81yK3QcvDGTihT+yMTJfKwj5hmXvbm9v3eCpLWQ@mail.gmail.com>
 <CANu4p=ZrQGmj4kPEiAmbKCvGi4Nbkm0jtf749KMkONF3=BzYNA@mail.gmail.com>
 <CANu4p=ZA3C-M+DBQ5dQqjoYDffBq3jW=LBKxfgzBZxreDmaj=w@mail.gmail.com>
 <CANu4p=bnLzAyE-+CGH3fuWhr8dTqituLHvTF2WuROAdNAXjQ-Q@mail.gmail.com>
 <CANu4p=ZKOd0Z-ALuv=H2OVf6iAuX_BjRZGXUh_O5Gkn1z2FbYQ@mail.gmail.com>
 <CANu4p=arYeqpgp8Zp1VVA7aQ=SHL1ywQO3of8Mk1HP9Rm__L+A@mail.gmail.com>
 <CANu4p=Y1_q4XSFHU1kmBWWoYOb5Spzovh2E8j+bZEP6Sr39GYg@mail.gmail.com>
 <CANu4p=ax21m_Yekb0xRtibBksPtJs_gksgueSPmSz0+cKicosA@mail.gmail.com>
 <CANu4p=YfbHiDUKQTztkQuEX1TJxXCCWKcjJj2GJKUwUkfrVbgQ@mail.gmail.com>
 <CANu4p=YjSgpkN1jPzhvwXBoH+ihtdNkg=OU9UHCYkLhPVvCDRA@mail.gmail.com>
 <CANu4p=Y2oSfvhoTxAJ0Mgo=axkQ9kg4M7LCYrbHRkm5T77z00Q@mail.gmail.com>
 <CANu4p=beTmnT5oA7dP5S86z7TPE=omVj+uTrTwjyqE_ko1SAaA@mail.gmail.com>
 <CANu4p=ZZ+qo+Bs6L1VTfJdqHFY0pEDv-92OWA74jD-zo6vt0VQ@mail.gmail.com>
 <CANu4p=YF=xEpiTO-uE99qwmGkXPLJ+VSoE+t==hDnrys8GzhrA@mail.gmail.com>
 <CANu4p=bFr+66eBjA49XCKG5Zesiy1+tGHxEqY6QpgiyMUch29g@mail.gmail.com>
 <CANu4p=Z5LwK=2aw-_gfESjaYg_0FxChhyi_72E3i8k1HvS7G3A@mail.gmail.com>
 <CANu4p=a1r-mt+9bRmwpKskMLtg85VQmjt5o=REyCHEWs+s+bfQ@mail.gmail.com>
 <CANu4p=YcoTrfTQOYvFB=DUZHQiJkorFbFJF_VaX__n=Kkp2JGA@mail.gmail.com>
 <CANu4p=a33H5F64uU4_iMwY=J2O9T1KC7-BYz1C9fxFQusrFh+Q@mail.gmail.com>
 <CANu4p=bFMyMwcGo5B59aObnGLpTWExErW9UzS+61po=UBKoGCg@mail.gmail.com>
 <CANu4p=ZRO9O-AC1YQVPsmPKkp7j4QQRr3snDF_VvXZBVMzocVw@mail.gmail.com>
 <CANu4p=aEE+z4eLrWUB0QD75wHrY8iD87d8uaE42GRFnq_yASxQ@mail.gmail.com>
 <CANu4p=YDa7J9eC+y7g6i14eDgnde29hHZW=nBxoWVWK9tTJ=FQ@mail.gmail.com>
 <CANu4p=YkiVkf1tomjurNf0uSYLYFjwfmai4yjZjKVXcEymvrQA@mail.gmail.com>
 <CANu4p=Zy0ZgoAtAbLLYJo5YiJp_DryeW_bFLaDQtpW-Q=8s8Fg@mail.gmail.com>
 <CANu4p=ZZdhokQNcJ-0TdAXXbQXm-e-qtYNsKi9SiANRUxv-gDA@mail.gmail.com>
 <CANu4p=ZYBai_0pv5Ahfgjg3hcqHZ3c3m2iBvs5K6XZ74ugSNFw@mail.gmail.com>
 <CANu4p=bLb5TH7_WZ7dbDaKZfa83Cuz=41bbdhv5Gjmuv8bnfWA@mail.gmail.com>
 <CANu4p=bhKFHZEFN0JYsMXAENNAoU-pNqeNbXE83hvVz2Xis-pQ@mail.gmail.com>
 <CANu4p=b2Ft2WZRDhPrGvJntVwy1r_iJ5M9Ot689g8OOzjcCA=w@mail.gmail.com>
 <CANu4p=ZNnmyk64reLTWdx9abH=9_RHbe0eBUVez8tq1NLfJTOg@mail.gmail.com>
 <CANu4p=YJ-vyTFe91uXVMJTEXNog6sCa654sUxGQYH2X_Jjj13Q@mail.gmail.com>
 <CANu4p=axstMjbgags20uL+gvzWQR7TGis3i_X+KLnReVs+dUkg@mail.gmail.com>
 <CANu4p=byKYeHARfqYD2d3fqVNq5EyLOgnjpJbg4LK1txLtEwog@mail.gmail.com>
 <CANu4p=Yig80xoKcxeEJg+UJvFgbE7Mo3Wsh-tFShF2Oj1hqEgg@mail.gmail.com>
 <CANu4p=a=e-Dbft14shT3oqrN1BVJc0Q072aZw1fuFP3UHO+qpA@mail.gmail.com>
 <CANu4p=ZRL06RfoULvDpjiGcMjGQeFFA_W_4JAeWPdce+frwLng@mail.gmail.com>
 <CANu4p=aDpn2cOGL2BTgHX8d1b2-88vpdA+ES6v439u9SyEzt4w@mail.gmail.com>
 <CANu4p=YO4PzCCFjsvCaCwbHr8OBsW5b0m=5qCc303QgkQxQnwA@mail.gmail.com>
 <CANu4p=a7SHibhDAfCTjooOpG37otStimHeB4r85To7hP+fQekQ@mail.gmail.com>
 <CANu4p=ZjtuDkurzjw0B+PmzQad1d0gpWymaawDhh03wbAv-3Nw@mail.gmail.com>
 <CANu4p=ZZx-sv0k8-DNAQW6EWFzAcXC=N2C+5dECXdJ37n63qQQ@mail.gmail.com>
 <CANu4p=ZEx06bMcDiHWJmTvUGUNV2B3=+xi2=sHajKcuMzi2OSw@mail.gmail.com>
 <CANu4p=b-9T64UnN9JW8JZK_9FLZrx8o7ssp=Km7nxoT6pTpSww@mail.gmail.com>
 <CANu4p=adKH+2MH0YTNFxWMZ88p8__uLZD8fvm9=DUi9pp2D21w@mail.gmail.com>
 <CANu4p=Z4CPUmr3OMojnQLfHsu4m2mV8gxLx7kYMHHTvYR7_Giw@mail.gmail.com>
 <CANu4p=YfU1CKLPrjcqhqiRfYH=UDMERr3Mz+w1VJHDGh3xjmKw@mail.gmail.com>
 <CANu4p=YcVrRGiy6Zj1vNWLaEvpmy8as6HkCTkmpo-JfOWHA8zA@mail.gmail.com>
 <CANu4p=ZmQ5Y5sidP6HFxk0u5qjrjtT8383J9QKjGYkZB0t6Xkg@mail.gmail.com>
 <CANu4p=as=E9gXZvYuoqiG_g5sjUsPhtizcHYdWPu=1LiaFJRfw@mail.gmail.com>
 <CANu4p=Zu+A4+7MPA--2d8fhTDfc22cLP+VCTYR7fODh_TMQXEQ@mail.gmail.com>
 <CANu4p=a93BCKmSAO6pqsBGyTAC6RwOUBpFxAKWeuar6VMVPyPA@mail.gmail.com>
 <CANu4p=ascuQqchVL_v4rmyc0EjgunAvwY141A4szuC=uNhvEnQ@mail.gmail.com>
 <CANu4p=YGZep4y2LWBqAfri8D2apsWYgg6veDLXmxYnWdyyCqCg@mail.gmail.com>
 <CANu4p=byZhXzW_kcbs9F-JDBTBiw2OC8UjV5SgXQyuby_r3wsQ@mail.gmail.com>
 <CANu4p=ZLnapXgk3RBmZ7UROBhHi9grNAPiccU1qdQJkKg1UkNQ@mail.gmail.com>
 <CANu4p=YWgVV3mj1ks4W0_wDFeL2U7f=0j=bRmLZz6eqYJLVgTw@mail.gmail.com>
 <CANu4p=YJvqz1AQm2p7+ooemYFQdB_i9uVdVD8sV6MaoobKyAog@mail.gmail.com>
 <CANu4p=bWTbhPpys6MzABfVGrAQ7YCPLb9gfKzek0yew6aFAYfw@mail.gmail.com>
 <CANu4p=bQ+YaW9vR+FkTeMFm8+2_Kv+Wt0dt_iMEBAGY_SNdMyA@mail.gmail.com>
 <CANu4p=YBJQVAp=kL9zVHGTFSFBfLzpNB_43iS6C7XU2nv4V1Yw@mail.gmail.com>
 <CANu4p=b3-+bxoLW7vZAyYPUan=RXjPmiZAZcHCjezgFoxNpbgg@mail.gmail.com>
 <CANu4p=bT_A3h-eXX5eNvgs7SKvC8MxdU1mvtHHxpDLVv1Jd3gg@mail.gmail.com>
 <CANu4p=aT2vnP3mjDSMdYTWX68hXmU=XfeZuPm7zjhnHaTJyp9A@mail.gmail.com>
 <CANu4p=bKNDqJTf7FWQwJAz3CBcOF_BLq8ivTJ1V=MGsLaGSrOw@mail.gmail.com>
 <CANu4p=Zppqd-SMEbvGZfeN_7inNsHHU87MBdrRaqYFBJVQWreA@mail.gmail.com>
 <CANu4p=aHMN1CU7BfQTtoF11p-+ayoCfC2Hkw53GmJUy7NxtdJQ@mail.gmail.com>
 <CANu4p=bb88S2=SPPas+yx4psDySjXKuWjTP=R=wmH873VSu1YA@mail.gmail.com>
 <CANu4p=ZkW4eyATWJ9HmioaXoTLGenNq9biDMOZtq0Q9mthpD9A@mail.gmail.com>
 <CANu4p=bu1swyw57cwyhno3hQayx87d9vxbQJOo-GyBF=ayy3eg@mail.gmail.com>
 <CANu4p=YOBHAFh7ignqbzKXWxcY9vVRgbrRyh2BXsMLgEm-W+sg@mail.gmail.com>
 <CANu4p=atrB7Zs0kL-UU0Xro8mAMxaL93iThVuddd-UgvWHy=Gw@mail.gmail.com>
 <CANu4p=aoGcJNK5WGSRECM1Hu5emA4v0M9u5LXESUZJeMa+bFFQ@mail.gmail.com>
 <CANu4p=ZO=wsoTvYDC7=SVmpFrMuq7iSt9Bmakmm-zXDWTnCb3w@mail.gmail.com>
 <CANu4p=aKy5tbcCpBgqB5eRzBWKocsEcs2-LFDGTfLm5qSW5cVA@mail.gmail.com>
 <CANu4p=YXikmYU3ooc9PbWkvE0W3E1Ce0PJ+0n7RH9XjOxRP9wA@mail.gmail.com>
 <CANu4p=YZJNCVe0H1KrQj+Rt4H4RYduDEzJ9WTeMjA-Ud6W_CBQ@mail.gmail.com>
 <CANu4p=Zwe9aU3CriuLMKNMWKAzqSZLr7QFdKZ56HZ3boVVFWDg@mail.gmail.com>
 <CANu4p=YQ4FVBQDLJB_CcyWF1DfVdYowkKXqA_LrZWdza8+NfEw@mail.gmail.com> <CANu4p=a5h4vkdGfthTbA8FydZ=uKMrMV16U0P7tjYuL58BOysQ@mail.gmail.com>
From:   Christy Ruth Walton <miraclegod913@gmail.com>
Date:   Mon, 24 Jun 2019 12:44:49 +0000
X-Google-Sender-Auth: RLvGUDTHdO50aOq2xb3_k4m5slA
Message-ID: <CANu4p=ZjWNf8yUCzQE_VKrYfuw_y4GbVFmbYEZ7xpL+z+kVaig@mail.gmail.com>
Subject: Fwd: ----------..... Forwarded...---------- I want to open Charity
 Foundation & Company in your country on your behalf is it okay?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


