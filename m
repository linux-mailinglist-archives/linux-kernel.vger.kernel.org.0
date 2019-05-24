Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5519429CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 19:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391376AbfEXRDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 13:03:49 -0400
Received: from sonic304-9.consmr.mail.bf2.yahoo.com ([74.6.128.32]:41317 "EHLO
        sonic304-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390960AbfEXRDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1558717427; bh=M+2BQM2x3GSy/dmtDG0o07y3ZYWK28QOQCLRz1DcS2Q=; h=Date:From:Reply-To:Subject:References:From:Subject; b=SXfQm9IvXxSorwqaA9cwTa2ROgULsAfhUM2k1NFMS/JcNj05u+RCLl4R/fZhfHW86oFCqZzTqUb8/fs95XHUzrGHKM2JEIB8/NGnm/04Vsq6+27yn/yIB3jhDNGB7dEmmhdiAAzhMp0/GEJkgQasOWCoyYZay+g+ILHnSuE/H90z0SiC9m4LmNxmoMpkoxOmhCilUN9WMAxNlbnlt4nfk0aE/LjgBu7ltsY7+CrMsBw0lQsbPfWU9i2O6RmjXiLHdh9HNFNMV1IzHB/B0rrOOJ2OearqcZW368LGD7U+HYgkBciM1uLtGvaDq3e898xCB4fBUVZkgGhiwJ6Gl96+1g==
X-YMail-OSG: V1NgYVIVM1nId53f.sSoypJqEFFtab1NBkiWt53Er_U407BZ_Z7F4hkjzMc8kdp
 NNPdG7i.v6.uAEpAJh7CbwdFe3hUUBrpndNHrqhoKDW8oX9mjMzuk8DgsJjXXBQCzIJ2qEjemgBM
 V6e4QnJGW0hbS8qEbz9Fy0KX2aWS2S5.abJSj9mWMNZ4sDtPuBbCPuabc0wg7cgZz_S39tO7YDA1
 gPnpyeIiCc2C3K.BgLFuX3NlPNO4W2fc_u.FKRqpuvYiC7doWrpF4QDI9yFk5W6H4aHUZpyJrDBi
 3ndoRIWrrHGjzwrEch2.8DjFxMHlErnOG_3eWI9iX_gfbbhla8Ex7qQcr.UQ9I2tmG5WE9Jr7d.1
 V9wJ1YHEOFkS4aSILxKGX..NNQPL13HFD4NbGJtucXX4aIdgP5WI0c3zD0Awene2.EFxHI9WSD5A
 u7D5uztWn3yPGl4O1JjX9XplutWdqHKcureii9896a4sVRJIlSTAxI7R1M_fUTIQgP6z74RRf23i
 mco4VvQO07yrf3Le3sAsPQhlE5j_Clj9ZDRjkt1OsLm2IoLc6MpxYU9hudGLbxvdhI31.0uCQPs3
 aQ7SX63Ob_6BVYUFQ8Q2ksCyLOuap7CAT4enrZ_zGSqQ4pwK0cTHCuMsP8RHZk4x5dI1P1Xk0nfQ
 rnr7kh5NYr8EHmKAfk3K9IwVYvABrpFoxn9Vig4HAvgZeLecTYozMFcS03Ae0LGl2Kk5lzCx7NhS
 iuXhXXmNC.ptxtbhWuZ1H1qIpeYJEu0qzMGM3i6nnYOgxdAi7FhBgwXDGxVKGgo5T_1XOxPfWU9.
 2sDPXVBJkeX5SmQhFpcipFZQuJkkuA2QDf3VYKabdZc0jE0czsGxm.2s5ERXJ7hrRGqBt7Dntgnb
 X9Qg7TlUajJ7It_4gqPcEmulOpo34Lw5kCf223Uzj7zIU6IOSyGR.T6kQhanWFuV6W.DcbkneGsA
 SggnHkwqM7XD1mcdHmwvzyMXaQxh8FuCANN_lTiavygs3cO4BXhZCjYCg1nb0yeB3BTEA7mQ0ro1
 vk8Zie8D8.e_SdpanlJFCbBatIdfJfiV.5eaOLLFZdQfqKDutnfbsOyUJNb1ysacoIyIdGzgyahg
 bumKZpsXUSdjgz9WVVTd8dnlYcRsIUdxGXZPB3eZH.30Wice5IWGjW9iqXYzuSCbQm4oz4mpNESp
 x044mxfUyfhKJNpqCPBMQRnVHeK4BJ56Z.FpnrC265QpxRj14BLQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 May 2019 17:03:47 +0000
Date:   Fri, 24 May 2019 17:03:46 +0000 (UTC)
From:   Aisha Gaddafi <gaddafiaisha25552@aol.com>
Reply-To: Aisha Gaddafi <gaisha983@gmail.com>
Message-ID: <1172799189.4484436.1558717426913@mail.yahoo.com>
Subject: Hello My Beloved One, i need your assistance
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1172799189.4484436.1558717426913.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13634 YahooMailBasic Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31
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
