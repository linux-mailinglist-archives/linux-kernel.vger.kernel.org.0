Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA616C34F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 15:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgBYOHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 09:07:54 -0500
Received: from sonic313-13.consmr.mail.bf2.yahoo.com ([74.6.133.123]:34084
        "EHLO sonic313-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730109AbgBYOHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582639673; bh=vFR/xlds8eKkS3F/y7lHfGoxODDm9autl1GsnmcX5JM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=dbv4DYl6BdWf96KCYSU7f0iDjIWR4YAG42elcXfcZUpZU7Y9WgwTOSx8VH9iUfLrkHSX4MXWkZu475bicFnm/bkBPYMLerbMQZMBk2gbUpvuKPThNLuWQwS7sMizbSrgovriRITCE0nsChtX7f0Z2hEYQ6NYI3rMfVORXXTnERDz59FWbx5TqE7foIIOjdndOpzu61Pit25swEDyVVsKLha4yNou3VFRB4clqzhBGmb8YO0T9IZVIUf+VBi3Q1J3BANz6SVYt7qThoXL3OeEbJi8/SG0gtDHAMoDFKcY5jTQnU0oG1uvZ3uLVkdvRTzbYhqxIE6YHjO+cnTN3iF/iw==
X-YMail-OSG: J7zUg0sVM1kmSiW0mufYM0GL_dQA7GWyvndXEyCZmt1qXoFrFBkv7ADPsgsyS1n
 dvrqN7tQ5Uws8BN_L_VUQPdXxL_StP7ctVZjJ9A99k76nzGV9772Yh2LxFsLL9ZdyaXfZBpahZe2
 Ir39GwDz9OD.uTbFX3bLMWNz9r4MZaVUrbCngiczMWiodk.1mrb7KhOzshlzdsUnxYxD7HY8BZ3P
 q0IFO8tobt9lBXhSpupY_w.zcFGeGwr9.RO9bY.I.U3A3pw0dGuNX0OoNAH4hhr7mrHJg4oskvYU
 uV4fSYAWs.lEua1qKHH3gJJTWI8lrs15Yv4I..69cHXF2KCpjUvRckcAlXPJcuzOmVdI7qtSYIJo
 u_j0qb0zVcZRyGaJ5f8QLA5CIo777l.4ymlrEqKZlPMeFvn7eBsssPa8d3nAK1xfrTZuHF3Pkou0
 tD1FPtZwCx03nTj.Hkw5UvWBR0zOKnGwHm2BGFNXW41QshBJ.fIVQOrVhnnguOSHX3zQy7.ykht0
 o1wJF_N3IqbLPJzUKxNE438xkvLKedxDk7xDUG8MW3BWy3DiXvq3P95pQP58kDlOSmgxDWxjtIcd
 vuni6XMyEaCf.difRfXDu_o_4tTp6EesoFp9sod8KBvwCxYiPdZDQHz8HgTu0Jh88YB.2fL5FK9z
 ifptZJx3.vNbDYHdpGAvzAtpAuoWh73pJRVpRR7lNlSiYY3MJzXi77_e9t4JH9TV.gc1WDQxqYy8
 4tQ8KqdRjoyKH6MR6tR_FuEojdR4uUrxEwzvkvkZWcQ0EyG5.VVQxLZodIXMXqOygQvMe_xqBToA
 NhW9YCEhilNvX8wmUFgQZdBNsOLfTYDhQ1O5ZmxlwOMYExNdbGkdlrUGdNnhgLdhR9xD1K9nFgXa
 6ElWSyghG7y6h0x_JZj81WRlHzKBrIAQYoPSFJwTksCuX_q50X.jdTb0o98O51fKlrzSgigsoLuI
 CPpKfLSFQbxRqg__nMbR6Q6sv7nmqeq1f49Du9aZa4Ye3rXHlaSB78aG5IkMm1Nuq29VhM6LAR8K
 QM0vf0R9k07mBCDICKYSwu4gsewakZGbI_DXvvSjuYP0frqWn1hAPa0d95a_Z3RpbspRUQjQpQM3
 kQhPU0MyvysmJO9WL7oSw9qPBpydod4WRlpUaY_nMDlMBaFHytzSZG8rkUkPTck4m5dCpzzcIONc
 jJdSk447DfohGy84EQUvDOBJbLxhgz5caXPBsAnuKpzvXYHdi03IljUA2ThdW.b7uvnpoSoL5AYv
 fgJOG8.fM.S2hMc.Fs1nASv2g0ihPLRTVLh_WiO05ZEm59M0bLfL8pLk7MbXk6t2UdhUqfX39OiR
 pQkOmycGqKcRscxnsV_sZ99dzlOaba3XCOSvBjA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Tue, 25 Feb 2020 14:07:53 +0000
Date:   Tue, 25 Feb 2020 14:07:49 +0000 (UTC)
From:   MR FELIX ANTHONY <mrfelix.anthony2@gmail.com>
Reply-To: mrfelix.anthony1@gmail.com
Message-ID: <796894690.121559.1582639669533@mail.yahoo.com>
Subject: Good day To You
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <796894690.121559.1582639669533.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15302 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:56.0) Gecko/20100101 Firefox/56.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day To You


   Please i need your kind Assistance assistance to receive this sum of ( $18. Million US dollars.) into your

bank account for the benefit of our both families, 
    
   Please reply me if you are interested
(mrfelix.anthony1@gmail.com)

FROM 

Mr Felix Anthony

      
