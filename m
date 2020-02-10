Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 565FD156DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 03:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgBJCa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 21:30:27 -0500
Received: from sonic310-15.consmr.mail.bf2.yahoo.com ([74.6.135.125]:37642
        "EHLO sonic310-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726935AbgBJCa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 21:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581301825; bh=V09D8a1N75lUFkJxVR9aVpVPFU2IfPbM8afoyzXI9EQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=QBDP/PPAachKq/13STc95UMckLHr/guQnSJofsWIRX0dBj7uzFBzmAyqyNfCX1CmJohZRY1ViipMammIpaiAEF0b/jCeeBU1eklh65qjhW8klSNoqUZYrkYfeDxpXSfFRHGLlsRFTgYp15+h5FO/psz/D1qlUF3jv+4y9/jR7WUYLASNlSPtbwthXwgLJFS5nJG2a2punR2C0F3xvD1Vqsgr9TtrTNjTQca8RiOYR3kNzBCc/LaFx2j3HSxwki9YUAJI+zsQTSZ4An++HAR8FIZbzrrTR0njuTaRRaI/qVlX7QENX1jl8ITEHg2A/cwi2yMeNwBdOIy4dIExVFpebQ==
X-YMail-OSG: ooPHhL8VM1loa_MD6VpB6Ms7I3gn9BdaDbITyRl50Fva7X4YmghKA8qRHDZlI9B
 imMZhCWTFRbwxejy1pWC832GUzB_ZYTt8IZCoB7ca8fJwICGgNNvd1H1nQgqJS7JhldP6VDrXgiC
 E6Pl9xIdoYpnYefwHWVmlNPkD8mPbK2mONbiINMyQvcAwzlU2a8_52otK9E8jbPXQ9WXipEBRf42
 pCES..Z7ZNa9Eo8IYVeLLuc9kkHvr1ln9cv.pdSYXGMo5hZW4wgq.KyA1eqgyGXzjlTv1nlSSojH
 RxP8OwdNikPvrXd5lDgLH.nqIRey6tAEqmsxkH5QNsBwnFOgzeG6BEgC5ezJcOMeiXTne8MGcsxf
 b0QCPIAS8i_A4gc0ywvOR9UBswzO1zCSMb8Nis9leqteYE303P4B_0.JVWcTYHD3C6LSvaTDGUyq
 1djrTE7Tk.INYVcPH7EcRKvI2AdXF2.BjS4wUne3JxxUsaP1HVzESLcyM5ChkodCgoxTJ.5w9ieK
 ROfxM3uFcLTEZdTeaznkMmZoivjVfAq5_t5XFMGwiFR.rwksVMnm8Wgz04RQqoNt5FdKeFNXY6kF
 ejmEzYYByKkPySybCqvSIt4d.BYy.0Y5rtkLITUTr.bvlMQRisy40vo.Xvjt6QDiRrA3mu4EzMQi
 2h8SQM6eDy9V3wR_Y6xYED7ok44OlgL0DMq2DtwXP8njbCxNhqzwczATL3RUEwsZ.fOUmdyFkCFj
 mF_gM9LOS9f.AHVJfgutqW.zLjnrZ2GOy8XE2mvTKheVw6udhxmqbug4Ekl2cyk3juVVbfR8V4lx
 knMm.33N.IGiF0Dymj.t7p3VCMovlOH35QQXbt7QVwdRO0velRRkUdazIkYRsMMmKZWOSJSpT32M
 gpX7Hnlb0O.K8Z8XIJINpRjLtrZabskDrSvpaFBBXvwgO95GjkLVLVdy2PPKkNr_xGWvSVnAAsyl
 gzy9KEF2VoNVfSzDKh2yfGoY8OmYViNsBxI5zWc99ZVyUoN3hqMK0exqJgUgK4KT1PxUt0nBTPRp
 hgTuE1m8q6BweNpzV3dL.A1HTaB7dsNeLlWBiBvZKbNBSJ2k.0jZFaEO_KOSrh0jNT4ydhinCyaS
 h08zGrodfFM5elwLX_GmRtkR910XXevLtSOueJIcb_vRIwCK_fu4L8JdDWUTvKkiluqj7Nc2VW9e
 vocf4mrEQuc5WMYusUIWYVffVI5YwjLs7Mw4xdYZ2VmHKz3Zde0wuY7EiPTtfWhRBWjts_qxbD3x
 rUydw7air74MFzaXYfx2ls3Q3Wwha1y2LRRqxelxypA6j42H5cHPrr7S2B6Q_gGX91.1kX5KTE9H
 1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Mon, 10 Feb 2020 02:30:25 +0000
Date:   Mon, 10 Feb 2020 02:30:23 +0000 (UTC)
From:   Ahmed Ouedraogo <ouea2345@gmail.com>
Reply-To: mrahmedouedraogo@hotmail.com
Message-ID: <1688363732.453276.1581301823969@mail.yahoo.com>
Subject: HELLO DEAR
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1688363732.453276.1581301823969.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I know that this mail will come to you as a surprise as we have never met before, but need not to worry as I am contacting you independently of my investigation and no one is informed of this communication. I need your urgent assistance in transferring the sum of $11.3million immediately to your private account.The money has been here in our Bank lying dormant for years now without anybody coming for the claim of it.

I want to release the money to you as the relative to our deceased customer (the account owner) who died a long with his supposed Next Of Kin since 16th October 2005. The Banking laws here does not allow such money to stay more than 15 years, because the money will be recalled to the Bank treasury account as unclaimed fund.

By indicating your interest I will send you the full details on how the business will be executed.

Please respond urgently and delete if you are not interested.

Best Regards,
Ahmed Ouedraogo.
