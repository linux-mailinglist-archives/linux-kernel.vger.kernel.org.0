Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DF317E290
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 15:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgCIOaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 10:30:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39133 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgCIOaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:30:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id f10so10163603ljn.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mz5fjrs0mSsUajUrEzM9h0IKulimwf8waudUxb2Og00=;
        b=Yb91KURW9BPiCoPWZVfj7+N9R9aJ1dksKE+s3u0ej6HeX3rbJqrAIYJqvab1/ih+7s
         fHOouIixdl6c30FiR5uYJnJTT8U06PLqyWJW+boqiBqWjVAXXpUThCvkycVPPTTCvf3j
         w1m3rtpTrLAjdEJlJWWK6wdn2h9EK+0i6DVZNHUBS79MAD6vq7/D8NZj0nD5hPhW0MpP
         MTJx6F74OshFqryA69fHCeo/Lc4gSQZF04PmMlGqH8Ec0wvKoSSNkv19UTarvJOpomji
         V1w+UxZkg1ETfzzmcd2Sh9cpLesS14FKfy95+CVcuoxSe8LdXG5rgPMfInLkSeYa5/T3
         mSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=mz5fjrs0mSsUajUrEzM9h0IKulimwf8waudUxb2Og00=;
        b=T0kzrOXtb1Mhl5TZWDf1LKzWl3e/jeuNhXucYpD+7a1zpSandv8QevsZqjJ1nq4KWb
         Aj6a1Vq4vbYJD7CY7ZE+qgOL3MutCEHunu/Mo/Pki2UCPOV6VD3Pg0RD5+YDW0x/HbmM
         6pEjmlRFKzSWKZC+/SyVOEEVjB3fL53f20HFRHU5sPbQQhoObnJpMG3Vt9geSmNDC07F
         E4BBzB4pZr16uXdHc2zl+wf0xol9mr+X0mQd3/pNaxCEKR1PYoL9HEDmV4Zmvmc3aiMU
         BsFG/XolM/E5kFq6lXHfP6acQ5d8YeY9aWU+h27H1hlAGMACyKBD+tEDbYP+fXivN3Eh
         MKQA==
X-Gm-Message-State: ANhLgQ3awCMhln6w2accDA3FA7zgarmnRPsq+VTMSSIt8vRHdqVVaWA3
        FEYvbtDhzK5C8saOcIuyD5n/v5oXSBeW9xHflNo=
X-Google-Smtp-Source: ADFU+vupXMaseVQiR6flU6pkZaIoR2XulFWJJ9RDirxkyBkop3rZqjTa7dltlD7SIlAR0fu2MU+bmsZxa+yNANz2GPQ=
X-Received: by 2002:a2e:9d11:: with SMTP id t17mr10166145lji.169.1583764200329;
 Mon, 09 Mar 2020 07:30:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:4a17:0:0:0:0:0 with HTTP; Mon, 9 Mar 2020 07:29:59 -0700 (PDT)
Reply-To: aakkaavvii@gmail.com
From:   Abraham Morrison <chamber00000001@gmail.com>
Date:   Mon, 9 Mar 2020 07:29:59 -0700
Message-ID: <CABLDrx51XAAL4bgOqH3BjZwkiVupUPdj4+oFkJxsCBws+TGz1A@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBmcmllbmQsIEkgYW0gTXIuIEFicmFoYW0gTW9ycmlzb24sIGRpZCB5b3UgcmVjZWl2ZSBt
eSBwcmV2aW91cw0KbGV0dGVyPyBJIGhhdmUgYW4gaW1wb3J0YW50IGluZm9ybWF0aW9uIGZvciB5
b3UuIFNvIGlmIHlvdSBhcmUNCmludGVyZXN0ZWQgZ2V0IGJhY2sgdG8gbWUgZm9yIG1vcmUgZGV0
YWlscy4NClRoYW5rIHlvdS4NCk1yLiBBYnJhaGFtIE1vcnJpc29uLg0KLi4uLi4uLi4uLi4uLi4u
Li4uLi4uDQrQlNC+0YDQvtCz0L7QuSDQtNGA0YPQsywg0Y8g0LzQuNGB0YLQtdGAINCQ0LLRgNCw
0LDQvCDQnNC+0YDRgNC40YHQvtC9LCDQstGLINC/0L7Qu9GD0YfQuNC70Lgg0LzQvtC1INC/0YDQ
tdC00YvQtNGD0YnQtdC1DQrQv9C40YHRjNC80L4/INCjINC80LXQvdGPINC10YHRgtGMINCy0LDQ
ttC90LDRjyDQuNC90YTQvtGA0LzQsNGG0LjRjyDQtNC70Y8g0LLQsNGBLiDQotCw0Log0YfRgtC+
LCDQtdGB0LvQuCDQstGLDQrQt9Cw0LjQvdGC0LXRgNC10YHQvtCy0LDQvdGLLCDRgdCy0Y/QttC4
0YLQtdGB0Ywg0YHQviDQvNC90L7QuSDQtNC70Y8g0LHQvtC70LXQtSDQv9C+0LTRgNC+0LHQvdC+
0Lkg0LjQvdGE0L7RgNC80LDRhtC40LguDQrQodC/0LDRgdC40LHQvi4NCtCc0LjRgdGC0LXRgCDQ
kNCy0YDQsNCw0Lwg0JzQvtGA0YDQuNGB0L7QvS4NCg==
