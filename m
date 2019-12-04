Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F416A11360C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 20:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfLDT4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 14:56:15 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:43347 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfLDT4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:56:15 -0500
Received: by mail-il1-f170.google.com with SMTP id u16so663460ilg.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 11:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Y5s64cDULUztNcj+XAj5kwGyOnu+jNjLT/oyzvuGnI=;
        b=lbhaO1dQlgHzGQ5/4HMIQNpdlZiHVoUDGDV3tjj+/pi9pCZkoep1cf8V5QgBeOuDIc
         toI/ovwS4rTeWE1+5kTjhxxL6kjb470G5qpiOx7GJiwRRr6VnK7pFMMvyeGZ35NguKoc
         ZUYtXiubBjwoKVFPdR+LKkSzD6rZPTo+nxA0wQPPlcAVH+nMhxUHeaitXbcgh/QZK0AY
         WnhjKU90RXxBnb3PtXqXI0cB8HPWPyhA19OAc1qwA9s0xDr/R+VedqHa6C8WpX2sS+Rc
         ioOvWq9xQCNBh9qS+xGfoOIkcnncMmOVcioOtRdojOpxJJwOmFY5Jbgl8UjtXOyrT5JU
         rtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Y5s64cDULUztNcj+XAj5kwGyOnu+jNjLT/oyzvuGnI=;
        b=MvYSG9ElmddQnT1kVoOXpte5mEPJKrYeeJVSZ/8rDc/rDzDBrY/kde/+1A7dqJjHcV
         /Y0QGxsxHmbW15SD2s/IgTU1RziCKI8joA4t8Dwt9JSItbrSQMsyODGY36Zj1+gNBliT
         tAmFA4D00UxyHgZypNuybA0OqKlyW2DhvmS/7DmS8XGKOg3Yz82hbiO46ePk3dvJILYv
         1HTCNVQrXJoW0tU7PqOEQIcErcYMWSDPZeNXMNcfO24cW4w+EzEdfRq+jDa36jLbfxxO
         WJKt5e6aSoqemzUUF/hqy9tBeXGKOWEv/OKjINK+PFKnFE0XYFLBH/zQsw0hj4mY6mrn
         FoZQ==
X-Gm-Message-State: APjAAAXWPXwkWj3wQeou+SO5WTvWFcPJpnacVEyGqarKK3g+ulSyAhDl
        r1EwqrJgIfcNwD0/etxX65/u3kwTMzvdViUKdaM8JQ==
X-Google-Smtp-Source: APXvYqwcACr24vKI7KQDbUQ+bw+TFSeLsgeQxf8+wvOA5AzZx+sH5UELtEFDWXQ2Polwg3Dv76CvaUjj30dIjMIEWnY=
X-Received: by 2002:a92:d609:: with SMTP id w9mr5538958ilm.46.1575489374145;
 Wed, 04 Dec 2019 11:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
 <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
 <CACdnJuv50s61WPMpHtrF6_=q3sCXD_Tm=30mtLnR_apjV=gjQg@mail.gmail.com> <CALCETrWZwN-R=He2s1DLet8iOxB_AbuSGOJ3y7zW=qUmx33C=A@mail.gmail.com>
In-Reply-To: <CALCETrWZwN-R=He2s1DLet8iOxB_AbuSGOJ3y7zW=qUmx33C=A@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 4 Dec 2019 11:56:02 -0800
Message-ID: <CACdnJuvTR2r_myJX2bQ8XTDw_HxM-EgqhVLaUJVCa+VQS+6Qrg@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        X86 ML <x86@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 11:50 AM Andy Lutomirski <luto@amacapital.net> wrote:

> Wouldn't it also be applicable in the much simpler case where the
> firmware hands over control with no IOMMU configured but also with the
> busmastering bit cleared.  Does firmware do this?  Does the kernel
> currently configure the iOMMU before enabling busmastering?

We already handle this case - the kernel doesn't activate busmastering
until after it does IOMMU setup.
