Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADADF43E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 10:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfKHJwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 04:52:18 -0500
Received: from sonic306-1.consmr.mail.bf2.yahoo.com ([74.6.132.40]:37957 "EHLO
        sonic306-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730623AbfKHJwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1573206737; bh=E+ks7AydzaUb4ISZTuxin7s0E6gVmk5020fTLYVYB5E=; h=Date:From:Reply-To:Subject:From:Subject; b=X6nj90XjtlU6T6ebLwSHC3Q5Y58VzSih6V9pYFaTPRCHugJ9LIj0Z7sEFSZlsmuP0GkVfKHFBIuTwHQLtd5O41SE5mnQY562IwpfMvYVYhF5jEmKATuc2KFCunYEKrVOGgHLrmpiZbPO+TKhecWagjKyBqvXjWVI047XcmVC+y9VbTdXisR+miE9lYEe3lAcGti5+4HkvF0tDQmLq2n2SU+6S2kF4hnlm7PxVy+Tbp29h+Ztg1LbY4nVVdYycp4YvsK4dsAr9Xjsy0pXQ+NQs5+C1R7JBGuMDkL8LA9uGYooUWkFVNws1MKbUeYymihqJLrKnLYmo4t/gTdWP7IwZA==
X-YMail-OSG: D7yO27MVM1kYO3wptMA_ceyfXv0Djd.b8APxJgGNvkPeGP5O9R433Kos3iUlMjR
 ucvQq7ZopJuBpdXht3L1K_QEuOb1TOHqJCKEvZZU.7wHoagWu.iZSwqHa4HTZ14ucWjC6nBR3QhW
 ebb1UFKCpgvJej7XxsRHIEtyZg2NL9EFH9DgBeWDliC_lOoprDn8B.LNLpuYuGcfmEgw6ozV4pso
 5Sn8jt7caQCorIpsxNbXcMJR4E1iqZ9B29FOkbr4x8SYKpk44EZ9C8iVCqwOSSzmuXM3gzf6khVU
 ofOCxacZwzsgLJx1IZ8V5os6uRMKVbzSVYGaAc9Xjfnuq6lyOvyDZf3nJRZw1bae.SfAZX47shth
 nN24obEpV789EnNFkRP55964buzTwzEOkwKspbidol7X6.XzYRawkMe4UtyWGsrpuHfW8uCsDJBg
 ZvjjwWch8leLywijkgK1AghZCAPp_068DfnnfRejEPwfVAaxbCY2AdNw7tf7_yr1lmVwa5jsjg_X
 xQI8HVPb5fCp48zt9HxaUmI6WA.Y2R9rs1o9mG80Cl6CXY15udPA6VFFxNoq.BBuBy3np.OwAre2
 _y5Rq6AM08_pr.yAPzoKc8.JuFNLdam5vpN2qSwNOaFIPW2l.unJAImt7mF19GVUby4DlsVvRBAC
 aPl2z8QGWArEEtgb3.LD5V6IoIwUxPj8kD9wNm99hZaF3SmIYzrFK9klQFM26MtHGsEivYFAYSS1
 8tIecMVuFFONrUgBan5SNdxsT1u77LlgdR_djDPGRoeZ9ZffXdEr1pt00KA5vdQfVU7pW5hb3Ugq
 TrwlOPrWz.rRsAFhX0sC54uWazvcXgzlt49ISR1iuJZt149nsOEjbqs.rMdkUD1z3JNpmIwwHWv9
 od1H6ifaypl68dzHklXb9LSaJW0H4EJb24AtzLRcEM_9AcbeDjg5Qlqz7amjRlKFHUVLlGTQ8esf
 wW1Sl5JY6RGOoXiEGMeQM8EOQ3p1iSTXX_DKCPF19l3sxbjogxiEFHkevo_4JCa3jTtwyoTNJhaj
 i.IsdC28Z.XmWysY090xaIi0CLYtsFd8FZJc6ywK77zK3UW8dtWqNyHJX3fPRIJBMfnNqxGoT__W
 x548evzaW1svkbsogw.crzqnol.Bd4rNx2UpN5j.JAwh9rUUmpOjx54xR8BhcZbyHeXIoKBPGXRa
 NAkFlQcbgOHWGPTc6p7uD566naAF6dSfpG.15RVibNfHXNzCmUt8qB7it0qMEY.kOIDIgwEhkqFO
 MV60FyGOMDEPBJHBiBjSKzlrMKkoBEENuyyaX17GafEbWrBj7sESTWh5enCK9vxr37pSxXgCmJ4Q
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 8 Nov 2019 09:52:17 +0000
Date:   Fri, 8 Nov 2019 09:52:14 +0000 (UTC)
From:   Aisha Gaddafi <aishagaddafi66@aol.com>
Reply-To: gaddafia504@gmail.com
Message-ID: <515539297.869345.1573206734970@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaddafia504@gmail.com)
