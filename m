Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC1310E701
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 09:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfLBIow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 03:44:52 -0500
Received: from sonic315-15.consmr.mail.bf2.yahoo.com ([74.6.134.125]:43900
        "EHLO sonic315-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbfLBIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1575276290; bh=ljzyZM62JhLsFQvRgn4oIHatvoomklO47Xp27/GJmJo=; h=Date:From:Reply-To:Subject:From:Subject; b=C+4wf0D4wWrTiEBUo2MdqWttH9NsamnQFwZy0dVYpiljw8+phIFQrvmsnbU4YF3ExHFZOvHEc+iQPDjJtYA4imnM30dcJ84TqXNDmaL/ANlXDrKvoWqQhevvIFgkCkQ7uPgFhcxe7UZh4U9F3AQysvuZeXXPt/jdMD7Jy9PbtSyjXex5k5/4DjsAchOaz8nV56DGnVDZpczvdnTdH+OESzTUfxhLSrd4Jqt8eW+LZXtWMZDtAHGF6cwhM4E/7YcdFSCgFq/OCwbw1j5U6ekDQruILFNi3oDJJ7TOajYd0Wm96WbIPBW60tLU27I/UOLoMhOrUlOIGIOF7F8pRgkpyw==
X-YMail-OSG: O0hPEtYVM1mOkGCvfOcCNM4ZnjDsYtnf0qI6.7BIV0qbF_3AO2KBBOcPlBsX17O
 6stLbp7_XvOedeIsEv7WueuGuz6uXt8kjW3Bgw.5uNxc6L8gIKFTYqCbDdUUe2GPs0iwyMOx3zJb
 l00UU8pWIVXasV5ODEtxlgBKWzWdfV0_DXHBCrKEXR3lmkka.RmRGmFdkc5R7w31LuyqfkpRQmzu
 t9kvHmwF_51GKPQ8vJYwadPVrMsj9V8AQnJLRCYi811viQP4QMi9sPGNN_y5HUle7b3lJXDVopnp
 I52NCoKcSu_OCezB4voC0qgrA5xT2lu6Hzy774LzBNW2aoyYFYSEsV1_UFg1vRNNGStYMod1VBHD
 efIeiXQ8a_YIgPXQf0dm22rToY0a5WAVjdNtVxyi4PlYSb76Kg337uN9iaBDR_mJBZiecI9v9KLO
 PjKjrkRBTy3b3ujvA2R1.TYRl0iZIyquxgiFhwW3f6QiZE0o5H_hRcLh1xrVzcla6Mk2WjuPY9R3
 qxqI_hBfo2eXvHfPbJmZLRrcqxaVFpQlds4S3mDd8e5yaC4sMGNcbqZsUBU0Sy4Bq5kYz.zkijLb
 ChfE9L.xRNrctQDx1lqGoe3BuPEpkLoF0ryKL01LWh7EyZqcUOkL80HEznuFzPEs4xr3dyIA7LIm
 73C8l1TlYIJRn96TXRFgvzM7GQgekyJjuyghiMhaqWCmhtD19l_qg_yL1J0OPR8U5qZAtQiNpSZB
 TfRuPjxTt0PF31QwVsGihejJz.9Wh4KNX427EGEpH7_SpQOC9jGEbbVbIng27fr.CIe9JJ8U3yNH
 AGpFemUiln0wzSrZsyc43BweeQMpVcXT6JSoS6dyjuTCL.cThmCQuQviJfaQnGGT3VKURbKQKxMZ
 VucJMHhfil7Mfjre8iVJPgMQt3d42hXGixCYUPqbtWEhCar15fdpeveIyqh7qdwvRkndzhIhYRPF
 6L97gomzivpzvAUBjYW5XhCIT.MaKTQJ_pTP3jY_nMgcwWA4xeAEuqR2ORF8vdeYuMD_4PvwXsrr
 JOYhKusUrUtmLFcAOdOUQMqV4aiTMThVSf9Erj6__GLFNB.YhBYHlekBTepw_kgL6elA4kmIDgZy
 _KzF_fTQcgELAuxX4zP4ewK_mx_v7nGBYINAfBzgUtC7Q1awTccTNx7t5ZUHX5GONy1mV61TFkeI
 WEmh7wTTB052TaxIwBgaMbkk7SxqXgZ9ktTs.R5UgHylE2kU6ppQ1ohOswCkQiW2hGSu9DCMPf10
 yGNoGa.4oz_zWsFjg5fus3w59yJ2RvPEGp63ok9N2XCtm0JCnbguPpX8ScqIq053R91.mtfwERRv
 xYmC3iHtOrhkQl3_WvDM6cq0S
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Mon, 2 Dec 2019 08:44:50 +0000
Date:   Mon, 2 Dec 2019 08:44:49 +0000 (UTC)
From:   MRS SABAH IBRAHIM <mrssabah51b@gmail.com>
Reply-To: mrs2018sabahibrahim1@gmail.com
Message-ID: <1722889697.4933855.1575276289795@mail.yahoo.com>
Subject: Compensation for your effort
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

How are you I hope you are very fine with your entire family? If so
glory be to  Almighty God.
I'm happy to inform you about my success in getting those funds
transferred under the cooperation of a new partner from  GREECE,
Presently i'm in GREECE for a better treatment  and building of the
orphanage home projects with the total  money.

Meanwhile, I didn't forget your past efforts and attempts to assist me
in transferring those funds and use it for the building of the
orphanage home and helping the less privilege.

Please contact my nurse in Burkina Faso, her  name is Mrs. Manal Yusuf
, ask her to send you the compensation of $600,000.00USD which i have
credited with  the ECOBANK bank into an ATM card before i traveled for
my treatment, you will indicate your contact as my else's business
associate that tried to help me, but it could not work out for us, and
I appreciated your good efforts at that time very much. so feel free
and get in touched with the nurse Mrs. Manal Yusuf (email:
mrs1manalyusuf@gmail.com ) and instruct her the address where to send
the ATM card to you.

Please i am in the hospital here, i would not have much time to check
emails or  respond to you, but in case you have any important message
do send me as an update, i might instruct the doctor to check it and
respond to you, meanwhile, once you received the ATM CARD,  do not
delay to inform me.

Finally, remember that I had forwarded an instruction to the nurse on
your behalf to deliver the ATM  card to you, so feel free to get in
touch with her by email  she will send the ATM card to you without any
delay.

Thank you and God bless you.
MRS SABAH IBRAHIM
