Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 833AD667BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 09:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfGLH0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 03:26:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33018 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGLH0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:26:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id r6so5737190qkc.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 00:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tX+z3FWO8ez0pwI+shF6DuNfmbSDPIMsw6ukNdtKjIY=;
        b=B1TBh6lQ8lJkZoPDu7qlKlHP93dzT2+gh7hAgAhd/UsfQKX68NCmLaYELZwamg6c2H
         I42nMWiepK94uoiPqaR1V1aHcqsTFF9SFuuzpCOxJQlCdCJCSGBUUq1QBGH1z1ofVQYE
         crao2BfDzcji5MitcsjQLOm9FGcbgnspowLDHM69zH2zUt/ElaR4EDvK2Ls4qhX3XxHY
         V5MhQeJ7ziDoekLRTZzdhE3xSBWR8EIJbYgn0+bJLRIr8lvOWtRo6oKZK0zbKg4VfC/O
         IHqUPhxghsZtxDQVq+EJ0Csb7hhQA7EpRSpU11lg9b0WBIXrG/za6qg3pJyfNRonu5SE
         X64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tX+z3FWO8ez0pwI+shF6DuNfmbSDPIMsw6ukNdtKjIY=;
        b=FXsq1VdEQYWRhG7qoYJRCxUxeJXhnbvckDgyKDwtG/uxejrKSTKUT6ETaZYS0eMAbo
         fecXauEiqlv5bZQ+YPCbr5l+jwosEeEnvx1BF9JZkDUkELJmyq+lIT/hCZNRgLPMeBMV
         yHPe3YLZ2LTCkdwhorVc9865gMdmbv3xyhKaYRXHJwMY//HRRDDXhVyWmEU/JKzC0oKL
         Olwo2771qHOBPloz9GiR2M4uulB+fhTbBJ0Z/vOx41LlSyK1P61nMDVxjObwDQ6SrA+l
         317/VZbB9sRU3JXLbl0f8o6uWYuRyV9WyF0a5NjAyRWA++Zv6ghPNkAOaEy6WGPX4MZU
         69Ng==
X-Gm-Message-State: APjAAAW8r7JHF4I6Dhxqd8RBpCAvj1H2a+dUTzIFjYxr/Dv3ixoE1BRd
        6koUyxGwCt71xMH9wmNgHJnYNiame/pyPGhIcxI/Pg==
X-Google-Smtp-Source: APXvYqwfZlT5gIR7C9KlVHynWkh81mOHdBr1VYyfvqhJ5xBafZ5mhfzv2ZrdNBgKteu9MNrfrGL9m4WEbOvxuI/NVvY=
X-Received: by 2002:ae9:e306:: with SMTP id v6mr5008989qkf.145.1562916364014;
 Fri, 12 Jul 2019 00:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190704105528.74028-1-chiu@endlessm.com> <8f1454ca-4610-03d0-82c4-06174083d463@gmail.com>
 <CAB4CAwc8jJQ2f8vpoB0Y6sc0fJmmrq+5rRuJ+TqGMMgCczRi+A@mail.gmail.com>
In-Reply-To: <CAB4CAwc8jJQ2f8vpoB0Y6sc0fJmmrq+5rRuJ+TqGMMgCczRi+A@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 12 Jul 2019 15:25:52 +0800
Message-ID: <CAD8Lp45Qe-GKrtCR=d4GCx+PPAtmMQfHK2VpmA_yHMNFJ3ijww@mail.gmail.com>
Subject: Re: [PATCH v2] rtl8xxxu: Fix wifi low signal strength issue of RTL8723BU
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 10:27 AM Chris Chiu <chiu@endlessm.com> wrote:
> Per the code before REG_S0S1_PATH_SWITCH setting, the driver has told
> the co-processor the antenna is inverse.
>         memset(&h2c, 0, sizeof(struct h2c_cmd));
>         h2c.ant_sel_rsv.cmd = H2C_8723B_ANT_SEL_RSV;
>         h2c.ant_sel_rsv.ant_inverse = 1;
>         h2c.ant_sel_rsv.int_switch_type = 0;
>         rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.ant_sel_rsv));
>
> At least the current modification is consistent with the antenna
> inverse setting.
> I'll verify on vendor driver about when/how the inverse be determined.

I checked this out. The codepath hit hardcodes it to the AUX port,
i.e. "inverted" setup:

EXhalbtc8723b1ant_PowerOnSetting():
    if(pBtCoexist->chipInterface == BTC_INTF_USB)
    {
        // fixed at S0 for USB interface
        pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x948, 0x0);

        u1Tmp |= 0x1;    // antenna inverse
        pBtCoexist->fBtcWriteLocalReg1Byte(pBtCoexist, 0xfe08, u1Tmp);

        pBoardInfo->btdmAntPos = BTC_ANTENNA_AT_AUX_PORT;
  }

So I'm further convinced that these performance-enhancing changes are
increasing consistency with the vendor driver.

Daniel
