Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A725F439D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388571AbfFMPQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:16:46 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37125 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732204AbfFMPQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:16:44 -0400
Received: by mail-yw1-f67.google.com with SMTP id 186so8481815ywo.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 08:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=gnCN30HvKaiF9XSTs3PRL9AEzeZ0SZrh5EkB5XUNopPYHkAytI1RHFMSC0D1bXxife
         eMuCKBzayR+cjlSEFnU69PQkCyR1aMGIkrivV3A0xZMmP+bTWkP6XcGXB6dafCqaM1eD
         pu/9rL5KAUAAe3m+9gHD/YMHgxSsfFX6/xVbrAW25a1T6F9BRIyIDrVbSMyt+V4Yt9BU
         AHjeSwGL/wLuJPlHCmvrUwCHmDClaBm88f8sf9MOw9WFxnCJ9RJfKDz9siyStCx4/FNs
         MOecgMkwxgdXlkHI5GbJD/hw16Cg7Ckfuk6EwwM74MRFVzfbruA7Tsf3BCo8F7sdlkms
         vY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=nwgZRhBFGhCd1QouvrVD3KHItwjRn0Cw1z7l8kyAbR8AVWZso5f8ifBmr14KeMZ8XF
         V7azL3ZAblyCQrUWjaE/2TtvCxgMMuTnGNiDU8aVRpNvLGO58hPqZgdM8cdzRM9StWDJ
         9Vac2rW8s+QClylvsbPJ+8idbDk0rlNsYBx/i62EDyZTnXzjpi242nevyM+BwwrW1YUJ
         eWFpamSk30DXqVqe8hi5oag7Su0S5UqYaaREFUhNJjIP8DnIztwISsAdPgx8811HZncJ
         XiAffEITzHEw1kYsqQRI66tHp84pUwrdxOc2DM8so8erZyoqHVN/mNt6pOpFqeqsvsaF
         +3tQ==
X-Gm-Message-State: APjAAAXbAfIXsSoNLb5GYfNI3YQubPUETPZRcGmrzJ0pviWF2h5SMHOp
        s6tjbbjhqsqV399Dgmmsxmp0nOGb6RiZVPCIcbskLg==
X-Google-Smtp-Source: APXvYqyOx15a7iRfVJfbsTBOpCszJefF1OgrjbLxuQIdlNyuqNK3huGTYHrbbWlGNVnqEBC1BPhmz4gBfqnmzcFMNlY=
X-Received: by 2002:a81:dc0c:: with SMTP id h12mr35140403ywj.248.1560439003530;
 Thu, 13 Jun 2019 08:16:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:1342:0:0:0:0:0 with HTTP; Thu, 13 Jun 2019 08:16:42
 -0700 (PDT)
In-Reply-To: <CADhnxkKCTw=ObMDjHSMoruZ95vewnJ3EtQc3PWPUa9T0XomxRA@mail.gmail.com>
References: <CADhnxkKu8E_JB1qUcW0_rFLUQgH8ckcz7fqA+607gsfD6+tawA@mail.gmail.com>
 <CADhnxkLyjgxtsvyn4CMLMHcX8Wswhu29qvCz9qO-FM_5opAqQw@mail.gmail.com>
 <CADhnxkJwXtDagAYCJOX9-kVOnehnKaf0ZqwWR5m+vziKLwy2Zg@mail.gmail.com>
 <CADhnxk+3LPTSi5gDOtDdkD3P-PXyNG+fL3tNFX-g2oBtsAcmOA@mail.gmail.com>
 <CADhnxkLjB5sQNgtWv0+Yta6Ry24qyfeotoNp22o1s5UkvJotfw@mail.gmail.com>
 <CADhnxk+1+rg=ek8HH0zBT4mzwPdPSgEcc9ANEWVQ7fd08fK9-Q@mail.gmail.com>
 <CADhnxkKQuw00hiB4HMj4M32dPv0gHALFKpxA5_eCX4ygpXbAVw@mail.gmail.com>
 <CADhnxkKZXt+g1HXZ22jzVR0G+4hOAWZB2CyXA9hzLbFH1WmoeQ@mail.gmail.com>
 <CADhnxk+FdT7P67f0beYbCWyL-vBGaWPZy2GHyE=SjkdQOVyP2A@mail.gmail.com>
 <CADhnxk+ufpaMk_ecgEX=Nmpq-Kvae_fW0K7v-WRRQuXzz9udHQ@mail.gmail.com>
 <CADhnxkJTVfXqO6nLaNukX5y6aqnyu3aNLGrViM55vBx6s6yPLQ@mail.gmail.com>
 <CADhnxk+GHLW3jpj8DuGbP+D4+ucdWjsP6zfjyPhna6T2+wmRkg@mail.gmail.com>
 <CADhnxkK3va2PS9VxwzRB_oAxudFXP7OEWmMF8y-vYcoE_KXX9g@mail.gmail.com>
 <CADhnxkKcGBbih_Prp=-2XOU8A4moxadgAH0NyEuLPM5pDyDkBw@mail.gmail.com>
 <CADhnxkKoaFHteZTno2WmsReGyFr2WyrUGi4VwDnu0D-g5ZqOww@mail.gmail.com>
 <CADhnxkLfGvy6AZNwYwk=tPFaK5AQwfkWAS+zeT0zBYETpbpRTg@mail.gmail.com>
 <CADhnxkKSk3edPMa28bgQkuB-mARQUdN+mKF69tmfT1QeC8tDhw@mail.gmail.com>
 <CADhnxkLk2PCgK4TX7UtYM25uZT1W4iWOPd4Wkw-XtbXc2wVkNQ@mail.gmail.com>
 <CADhnxk+YpwQv9MYMPBwed0JymFLZye2LZM8Zf+izRMLR5BZN8Q@mail.gmail.com>
 <CADhnxkJJmWyHrDVpdPy+NAy4ceq6_czaCcZzdfg-iQ2X2zNd8g@mail.gmail.com>
 <CADhnxk+si3akihfZbC_NeMF=dr6aC9A943FkNZfckU1XOTEDqQ@mail.gmail.com>
 <CADhnxkKbnAW12hXJVW1670cnMJ5bd7TnSTg14n7DY01oAM0cGA@mail.gmail.com>
 <CADhnxkJRMf4NUHXc4=N3qOeZkDKSTQkvY=m-jsrUTRpAjKGjGQ@mail.gmail.com>
 <CADhnxkKYU4YA7o=hJ9BCdjR0zQgOJn2yciNYXf3oiRsxZ9DpaA@mail.gmail.com>
 <CADhnxkL3rvV_c-U2aebADHxPdLhAD0nKejz+56+rmoLd-O+q2w@mail.gmail.com>
 <CADhnxk+MOwaDAb36tXK=Hc0T5GimOhOq0ksKgeYK9kYJA=-LAg@mail.gmail.com>
 <CADhnxkLLRVGEGegYkkfaGFBkhUx8dP26A5XFAqSd9mVrogm+yg@mail.gmail.com>
 <CADhnxkL9uASWED0Q0zxb-LDaq_yUzPvVpB+DQys2E+4WfU_Maw@mail.gmail.com>
 <CADhnxk+R-rZ-Uam57nYqR3vq9Opg8U2eJdRPC+3nHwW0wGdkNQ@mail.gmail.com>
 <CADhnxkL5csi2jS4s-Zxmep5hWvTJ3vPeoZSV2SFm1sfYNkTMUg@mail.gmail.com>
 <CADhnxk+SwFKbvs-4FooCp-+KhsFwxMqv798O1q-WG9ar9OQqxQ@mail.gmail.com>
 <CADhnxkK3uaPW6rB+XdCOVWg4yzV0MM+4nGQf_gxrBKVFGieWdw@mail.gmail.com>
 <CADhnxkJNqSP5KcO8COWB-jDDwRNA53vcQe=5rXrh0UDQaqW1EA@mail.gmail.com>
 <CADhnxkJJy0_w-KqjuUMo_-TSzq4AaT+cuj2LSJPGsQeeVe5StA@mail.gmail.com>
 <CADhnxkKS2DvRZZpr1ZVfPq2x302O9DN8QmZsmop-fZ51h2608w@mail.gmail.com>
 <CADhnxkKtCzAnXY3sjp9BK1hxVi84EcgtMeEr7jJNfgkrTBSkOA@mail.gmail.com>
 <CADhnxkJQn39QKmbwxMgqjUuRb3W3oR5jPBrnNZFBBRdLJFZAEQ@mail.gmail.com>
 <CADhnxkKB5A48SJ75LnYH5axQBwo1pbof6T39L2u0=rJirRaL-A@mail.gmail.com>
 <CADhnxkKyBVQqDGq5psYqjCemoxAODkJVmJnOeehC8jBVUZghoA@mail.gmail.com>
 <CADhnxkJwhMWLW2AMvKkgJ=gQxa8sQe3+dmcfJ_LF1CiaYkEX5w@mail.gmail.com>
 <CADhnxkLhKD3OHx4+szKkWauCshdst_62L9pNXH1pHi+fDM3Vtg@mail.gmail.com>
 <CADhnxkK0T4RocqUYY554nWcsnbyb3szdxkrcDROJ+LeK_-2vag@mail.gmail.com>
 <CADhnxkJa_a9xfwuGH=jEhWjQGrRrXyhLKUcQ+a5sDDG2smV=vw@mail.gmail.com>
 <CADhnxkKT6ezPMi4D=cPgv11uf-znfoiE7LWBm9dAb+dj_3mSgw@mail.gmail.com>
 <CADhnxkKkDixMDdjjtMXMKA-7vJwWmEiH0VdLve7ij++MGPfOqg@mail.gmail.com>
 <CADhnxkKG+wy9FMEPFR5oeuB_KN+nJ+FCtpD5OeMJBmeOwGC7Aw@mail.gmail.com>
 <CADhnxkJY7uCA+8o6E5bMsGp9mLH53qssFEQ3JiH0qWbxf3DSSw@mail.gmail.com>
 <CADhnxkK8VP9SKSB=MnuyMfrqk9hZw36=qBs5c1CusiEzTf7R4Q@mail.gmail.com>
 <CADhnxkK+p0uz=sc0jKR3vgTD=Z9vbtzVBmFxO06A1poXD=O9KA@mail.gmail.com>
 <CADhnxkKGcia+=Oh9=jTG9t3GNQ6CLvE=TDRibQdNcFA3OXonfA@mail.gmail.com>
 <CADhnxk+O1Q262vhcW24deK=nkuST3RHPG7VkSNDTygZDATk9Fw@mail.gmail.com>
 <CADhnxkL=Y7S7HsBodEs8KV46RC-5SCPaE95Linu38JWYR4ysZg@mail.gmail.com>
 <CADhnxkJ6z9-7F6o3JJbocEpOJWzVWHzXDAyXVXscixyp8LthTw@mail.gmail.com>
 <CADhnxkJ9-_oXm7OyRpcVXH+eeTVno58dmEXTBBQMZgbZnCkJpw@mail.gmail.com>
 <CADhnxkLUPaTKwSjnGk2y=7oLwbsofPyYGr-JOOMg-OVxQY23-A@mail.gmail.com>
 <CADhnxkJzOchoHrTj4QtUmmecp5ETX_h4h5VMX+8uSvLvQ1KKBw@mail.gmail.com>
 <CADhnxk+cRibA34b-pXur_WNzWoA_Cja=pETMO3EMFbBFABUhwA@mail.gmail.com>
 <CADhnxkKDq_9cP=7QOEpWzMAXEyrR5H8hq2sgcc1AQrJX_jNuNA@mail.gmail.com>
 <CADhnxkLJg5iXRjz7O5XbtRJ9QCzeCTvfE+faKsmZB4zbGwhADQ@mail.gmail.com>
 <CADhnxkKWStW9SSt6ef9MRYvJhcdBrks+L0EJYC53sz3f_+La3Q@mail.gmail.com>
 <CADhnxkKCa3vxA=gK_PkL6i82sM_hwRGx5EnvDhUYNT5arVDJuQ@mail.gmail.com>
 <CADhnxkLBwqrdKt9TvuR121Gxqivde5D5OmgdB6D3SYfqRWUrNQ@mail.gmail.com>
 <CADhnxkKtEqqNCu2Zn3B1knQ5WypN4iY78vicz+Wr8joNwsxF3g@mail.gmail.com>
 <CADhnxkKkkqELA4YnxtwwpOjbczH43T0LyCJHBO4GBit8o3NPjQ@mail.gmail.com>
 <CADhnxkK0XoZOPR2jTO6Nq9OAqhvMDiUJVBNgDYJu0tu_Qp3wog@mail.gmail.com>
 <CADhnxkLfXhw3_fnQ4xWMWjwx33VDYyeqJKojDCj27BE-XAg88A@mail.gmail.com>
 <CADhnxk+ZZ6CNx7qT6LpSiaL8jq+yXmOCB570tQO+SYUW0a0LCQ@mail.gmail.com>
 <CADhnxkKgBBgYewtHvj9ePSKSh9akEN9MsRi=t_hG-Q0d7RZGUA@mail.gmail.com>
 <CADhnxk+PnA3r34TNbywMiM0Kw8iDDy7FjWKsTMQfbWh8=MDDMQ@mail.gmail.com>
 <CADhnxkKhvpx+PqP3moN4qQ2s8Jth8F52pO3uQR=rZk9MvE=-Ug@mail.gmail.com>
 <CADhnxk+8W=UjF9i+x_voAn5E7W8mXCSWFAmWEaaRnus6GaJwjA@mail.gmail.com>
 <CADhnxk+TG9fpPKf6MYuPub_9WG3y===LstzpV1V-MNhhr-ykfA@mail.gmail.com>
 <CADhnxkLx4pq-7-Cn-=+J-rGi7q9OHdJ24_+e9FDafiFFu=Nb_w@mail.gmail.com>
 <CADhnxk+bH2sUNO73N-Qb=+Xe-rbrN6RCJs1dQLgES4VsCsAGdg@mail.gmail.com>
 <CADhnxkJO5GaKheXwW4=bQp404ESQZ7gZGU49Q5hzteeV=G3ubw@mail.gmail.com>
 <CADhnxk+9ST8Fjp0hk2kYrBj2Yr1w0aqBVkPf3684b9MhV2BZtg@mail.gmail.com>
 <CADhnxkKFDLf2O6+Ow028Ht35HqS=m_+p6ZSJ4NqPRpEEBmy2ZQ@mail.gmail.com>
 <CADhnxkL5eOwbiRCUS3vZac7SzqbrFUG1wk0-8X-94ZZJ+mQsOw@mail.gmail.com>
 <CADhnxkJ24hxv-NtC9Zy=wox1XsEg3LC8Nf54ZTQfziqLnr6_4w@mail.gmail.com>
 <CADhnxkKi1v0=sXt6kpHG81NU5Eo+as=PgCZnrw3OASpgKwy1Sg@mail.gmail.com>
 <CADhnxkLRC5v5X5c0TAGHL2u70oWG5E308B6Ypp146FC62Ar3pQ@mail.gmail.com>
 <CADhnxkLeg7H2JBawr2nGhPhoxWTD4W2c1BCj+rUNL7a52F7bGA@mail.gmail.com>
 <CADhnxkLNumjLAJanxdDmjBjua+cOecdjP4c1p3xDEUsYJ3ryjg@mail.gmail.com>
 <CADhnxk+N_1xUocR-GEMRvRE6zWudqWjRh_cSXZfr6bukXLAxQg@mail.gmail.com>
 <CADhnxkKaGJkw3JXR86a5WFeoQfanLYTaEdWMw+=+670tVRfrfA@mail.gmail.com>
 <CADhnxk+D-rELU9GJDjtSZrdM-ALt1gNMWFgs8WOu8Luf7hB53Q@mail.gmail.com>
 <CADhnxkLVriQg=x7NuyD0M_5Ov6kkCHow3e+SFyAe55sC8dkVNg@mail.gmail.com>
 <CADhnxk+4e0xn=vwZY64EO2UNn5R+KFAoriTaStnt35f8ZYeHrw@mail.gmail.com>
 <CADhnxk+r0yxYRfLfpcHOCk9ZEfX-t3PaDtPgQBPtifV7zsyxqw@mail.gmail.com>
 <CADhnxkJGboBw2KjjPFW9EPwy1FSKC+wzYbxrbBqWo3A+e14dOw@mail.gmail.com>
 <CADhnxkJGburRbB3wdux_t6aOuCbQ4DPYgcrujbaou6-YWTbcqA@mail.gmail.com>
 <CADhnxkLDPFZMhLuGVoSy0YfA2bqNdsgk4BHon=OVPh1UZrAcAA@mail.gmail.com>
 <CADhnxk+aWymRXtLc63h9kki96Fs=GDt2gAAMn8=8unAUfedxXA@mail.gmail.com>
 <CADhnxkJPsRLhEFHR8-E=+oNch66nFob1gKV0EuvanZhQNe=q4A@mail.gmail.com>
 <CADhnxkKauicDTiXfAjpsJcUUfNJwGoQxb2vHJEwHs9z6=URNxw@mail.gmail.com>
 <CADhnxk+8Dfp0vXKOayeYpqfCUqyzh1Y=Eh2ANg+-X=KONe6EnA@mail.gmail.com>
 <CADhnxkJJMV0Cdmk6gMAavs5fGns0Swb3E-XJfe8Youie7oQ8Cg@mail.gmail.com>
 <CADhnxkKG7_gCiEUatfFz+JpD+yNXPe1ZH5A9Xkq0=bjifRdOiQ@mail.gmail.com>
 <CADhnxkK_4Asu-Q4MRUpUA_yY=3tKB2zv1_e_2yAmWpF+MeaTBA@mail.gmail.com> <CADhnxkKCTw=ObMDjHSMoruZ95vewnJ3EtQc3PWPUa9T0XomxRA@mail.gmail.com>
From:   Christy Ruth <wonderclaudet.0@gmail.com>
Date:   Thu, 13 Jun 2019 15:16:42 +0000
X-Google-Sender-Auth: N5ic-TtgJnm2ekeKAXehPCbqrYQ
Message-ID: <CADhnxkKpJMik0rN=hhc6jv_7H90XapNNpg2LmgQpKS3A5vuGbg@mail.gmail.com>
Subject: Fwd: ...in your country... I want to open a Company & Charity
 Foundation in your country is okay???? Christy from America...
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


