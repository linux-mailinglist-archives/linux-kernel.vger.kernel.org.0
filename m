Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE43133B77
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 06:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgAHFy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 00:54:56 -0500
Received: from sonic303-1.consmr.mail.bf2.yahoo.com ([74.6.131.40]:43852 "EHLO
        sonic303-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgAHFy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1578462894; bh=KB5k1+sCGpSRd9pTKc0P9/4ZGPy9ZVtmix5g8Hf7Eac=; h=Date:From:Reply-To:Subject:References:From:Subject; b=hS5yJo9/0S3jcVRgJQnyqDZbweGxbOFKAXFnKoRyoozEUH2hnXBh3+YgQ0ROyM7UGsOTCcQUWfw0shsLuCBEH4xPHcsGLkoXklXSw32UqbKVGKoSMfWF6KrOcgQkT/5M4x/unFpfUKFlSVKUH4SMyYbXWe/krFRU4mkSheE8ZrD3tecvg8CbVG6HVKsOiGQ2ruPf0HgdodcgSbOGOT8V1tCOyLqLTb0ZCqDO+szruTXgYrd8rdTTC90YnD6sdszp6J9aypAvcn4+McrqHfIFwy13rQ0JbxaGKZqFs9mrhkN2HanHtc2y+0fpIj5qMGGox4/vezILq82imhY8aMNLFw==
X-YMail-OSG: OA_gZnYVM1mfQ.LV7uS_eghIqLbwj3U1qCoyQ9z9fBsqqsfZfpcOLFTR4ZUMj2g
 ywCWwQoFU9mTXRZscmjXU_BQ.V5nnLsMXaGYibS4P6M4xKGL2X6v5yXqhkoJ.g2wQ_SmYSA1eE1L
 cSHVm4mP8limYVgLcDzjkGvZmQeZne7g.y5pAKSH21bJG6kaX1ryZuEc0IUvmRYyyHB8cw5h.7zx
 2lclEeg5RorJ25cMqxCicVHxPnmk5kQTf2FOeZS5HrWo3IJoM5o.r54vF8I.hHesFpE.VYxbcLlu
 kh851bLFzPpCwm8bepvj8bxvY_Y88SOYMvDA2XMyehSwf7_ZFh8RX.4wY35w35iVag1Gz1FXvXoH
 bgKnFcLd9okulbrtrwO0zI8vH7e6s0Rep3TVBG.5YQemEMTcxmyv1bnjOx7PFsx2gWZFqErnQzCR
 o_3WpmB3dMgUTy3V4Jg1dbR3fo6BVERw6TUTqN2867xCIvITYemzswa_pDq489lWn7AUiE3S7rLO
 vUtYNcLQDLk9uWjzstVIyXHu6rAC1FhyGeDWJvrrL3dYqBM5eTFUE6xfHuRvSE85GkyduV8oE7t8
 fc2oOlmqao6sXs.wtY61D1oVwH2CLS_3Y6FCD.KGPrrnoRS.RngYRE5vr8x7WzWwKd5Qrj9vQLVK
 01yL9cCEibu6ErGna7RztnkmSWaIPRFCatOEngUhnICaRlJZEeaxbnaFx8_2T5Tqb5BUISicAvLW
 yAIjxIxEJgASPO10lH1ox4q9i6n0sVfd.c52crDPoDZrmrta_74JGm90QqtRtl7jpzTIpj0WqqUD
 U9XHEC9AfSSu0scoA77JulZXaqnV6i2A3M_xL8Yo0qmHxp53xRRynQ3xwErr7oMrnTfUCzfXULTr
 LUcc9HuRTuaCKLHlg5nhDj0TIWNm2gQpKDCWnzlNODnXPC650Og6xcfZX1IxLksvGDob2u6u7qkt
 GZTF4u9.82saYzyLrIbsPR3ycam8Z7IjV1sgXuXIDiC9jqxjlTX57CpzPY1hVhzvVsTxlo7pDjpt
 Lr3Zz2CcTx6Tw4Dz0rGdBmpyOWcL1EgcsnorNQnC1aLFux9wtzrblPFB2PAceT.ICoXdiPn55thu
 G3_fAcmqssQe_srknH2AOhvWX1pnBk0hUHwAzh8R2GxlGfV.3QPnketFCcsGDrPpONlmGq5HnOIP
 WimUF6AaprfNguYTAZkESUzH3yRaLkYDlz85Vr0ldqBCNb5LK7jJM2mKqYPAjMKirTcTqZZf9OX5
 ww8hV1wrw5D_NLoPRJHh92bKB6jJ5f.nDQ87G02eJ5eEtIPMpsTdtMvt7.8ZTIGj_mtIfj5hv33j
 3adwmI6R.G.L4jtNLiOPj
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Wed, 8 Jan 2020 05:54:54 +0000
Date:   Wed, 8 Jan 2020 05:54:53 +0000 (UTC)
From:   jerome njitap <jeromenjitap10@aol.com>
Reply-To: jeromenjitap100@gmail.com
Message-ID: <1751629494.5453446.1578462893197@mail.yahoo.com>
Subject: SESAME SEED SUPPLY BURKINA FASO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1751629494.5453446.1578462893197.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:71.0) Gecko/20100101 Firefox/71.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir,

This is to bring to your notice that we can supply your needs for
quality Sesame seeds and other products listed below :


Cashew nut
Raw cotton
Sesame seed
Copper cathode
Copper wire scraps
Mazut 100 oil,D6
Used rails
HMS 1/2


We offer the best quality at reasonable prices both on CIF and FOB,
depending on the nature of your offer. Our company has been in this
line of business for over a decade so you you can expect nothing but a
top-notch professional touch and guarantee when you deal or trade with
us.all communication should be through this email address for
confidencial purpose(jeromenjitap100@gmail.com)and your whatsaap number.

Look forward to your response.

Regards
Mr Jerome
