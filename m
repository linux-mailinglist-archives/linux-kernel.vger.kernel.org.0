Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D24194BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 00:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgCZXIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 19:08:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36532 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZXIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:08:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id i7so4032821edq.3;
        Thu, 26 Mar 2020 16:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjVmzAATf62uYEZGFDdUMmZJw/Rys56Qr6VbgpTrVUM=;
        b=MVcDwGSBB+EFkrtg2gmqZWSXAq9mYwRWCEI/YzTHcuhAVWx2S83wHDdVNOT2k317HO
         I58EWGrxVervRYnIEjlAPTboaD2fUW4UnujQzjxOc/YD/KuKUfSM0YPfJ0kaOYjctOU9
         iLGd1S8jxJh0FNm2TCO63sBqyLxA9gvTQ6lM3Kxy7/HWrPCJiXfkoFOzDf1Hr2TDsi5n
         kJZylePdzvNfkiHQhhY9XYPnnfQz0f/bP/0pK1Q9B5aC/cLdpgeEIfBPXCNIqpbG4pBf
         l4c06yIRKxwuFcM4kYo0VFj4i8x5CeS7aif1AeAVOFIFnY3ekMkSxbJTtK/n0XEHXNF+
         VbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjVmzAATf62uYEZGFDdUMmZJw/Rys56Qr6VbgpTrVUM=;
        b=RewQtkXgZ1yAc57Bq1IcDFuEtU+68zIRum1gduFnfhmcY5QRshGmgpIWfw87abkpw2
         Gde4h81h9uHCtP4pgqg59RIvfHtkq0wd5ody2KWAaVx0kR8xBi8hWNa/vuj7GXKQMi0H
         4yGtt/ozAvdKxLWi/dn3qxpAftpz8UFIIP+7tmExMY4GSw+TQaT0//iOb2jF1YjWmHdY
         uT6cbGUHOXUeXpt0vvqyNRxDm1Aqjgrd+Xp9YcvKeD4s/cT+53W86WiL18ahzQ+OO5OS
         eJAm/1y45g6H1zipznPFmBMODeHMECqChZrCWM80TBffNjSeAQHYbCj3c4TGaG8b1y/P
         CK1A==
X-Gm-Message-State: ANhLgQ2IrGTi+gUjVmDRVk2dVFwaT3M2/eJhgclhyKY0+79+t+Eq3Pz5
        Q0E3YyJlJCpl0yxoPCvtulEDxNEvBWkPkS3dSkU=
X-Google-Smtp-Source: ADFU+vtzMTlvDFueGZkf+gigtXaPCQtDw5qM43N1F3qnk+rE96BbiGe2gqw9PTPkca4WmE7xjFnfdD1Mkjj7dwNdgb0=
X-Received: by 2002:a50:9e45:: with SMTP id z63mr10637427ede.338.1585264127824;
 Thu, 26 Mar 2020 16:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200326134507.4808-1-narmstrong@baylibre.com> <20200326134507.4808-7-narmstrong@baylibre.com>
In-Reply-To: <20200326134507.4808-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 27 Mar 2020 00:08:37 +0100
Message-ID: <CAFBinCCVTP+MrLq1O0m1pcvLo6WSXyXpTtWMEQQxOuraN+yA0w@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] usb: dwc3: meson-g12a: refactor usb2 phy init
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Mar 26, 2020 at 2:45 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Refactor the USB2 PHY init code patch to handle the Amlogic GXL/GXM
> not having the PHY mode control registers in the Glue but in the PHY
> registers.
>
> The Amlogic GXL/GXM will call phy_set_mode() instead of programming the
> PHY mode control registers, thus add two new callbacks to the SoC match
> data.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
checkpatch reports that five lines need to be checked.
these all look valid (for example: "Alignment should match open parenthesis")

with these addressed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
