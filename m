Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A9F2CDA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 19:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfE1RcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 13:32:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:47029 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfE1RcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:32:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id 203so14898814oid.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69Lkov6l/YB/g8drnt7LyM8Q4caLCPlGFpwyFiDm+Fo=;
        b=VYeNvbuDqk8y3j69S5xOU3CpUaGT4a0Z6qnHUepKh733tlWbbDhfymXdNShIk149Lw
         rRlczBX52L6p2zhDLux8TM+hsLjA4wc7XacC0mjdPvsGN6DmCCqPDG44VTfXvrXiuP+D
         Pgq8ci5GHN7n/OwXsNcD+RxTofVdtGqPGrurJ9Idyrt+rDVriKAc0shCOVgPKBL8WxnC
         zlEA/FLewbomDR3+r4OxAk7YZn88Ph3/vOau5KwUqxtCULuvbNue33gSpqvPzLiEu5Jm
         J4jKkjVh7K1DWni1JjPf1YITzZTTv/FJ/dIfFOQIofs+Wl+CyXAEmAkqi6FGWKjhGWii
         bJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69Lkov6l/YB/g8drnt7LyM8Q4caLCPlGFpwyFiDm+Fo=;
        b=EXSnTxCRaZx7fUxF0/wRXWe1/JEs7drzGKyz9R6gi9cX6dwIAJisOZlAiiSdNCX3WW
         PwAnLkP1deNsMv4dEfYda3IhEktHk3/Fj5xJp9h+vFJGZDX3PaOJiq6fpKDwcFX8jhOZ
         zQJ+tVKnb+86nDdZ61FUZUjyOqGCV+eZygW0Oly3Xj1NhTKutjr6mgZml8UwqiIyvV78
         1m7zXd3stJ01E5/WX6ybtMZ86iJ3iDKHtDK4dgvOlzpIrgQqaCUk7AqooIZwagEx9+IV
         SEvQjmm/CG+LqmpOppGTbWXCtxLu+31+8fSrP6adj3R+U6JPVaErU9pUJkW7QPBfgIgL
         fdwQ==
X-Gm-Message-State: APjAAAWCXi2DOZVZsskFRW95Kau4p4Bca6OwJBr5be3QNsbFn0sPY1tR
        f6ezqT7lYZxDqj5AETu4yERC6tHsbIrMILTwgBxU9w==
X-Google-Smtp-Source: APXvYqxn+HNU/x1cDWahCiYdLUAroXji3RhlAzBTq6bh/v0lg1ZTn6o1Cg3i0g6ncRZ1i0tVs9UbPO9+4sAfRzBn7SU=
X-Received: by 2002:aca:580b:: with SMTP id m11mr3252148oib.169.1559064724380;
 Tue, 28 May 2019 10:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAGngYiU=uFjJFEoiHFUr+ab73sJksaTBkfxvQwL1X6WJnhchqw@mail.gmail.com>
 <20190528142912.13224-1-yuehaibing@huawei.com> <CAGngYiW_hCDPRWao+389BfUH_2sP4S6pL+gteim=kDrnb9UDzQ@mail.gmail.com>
 <3f4c1d4c-656b-8266-38c4-3f7c36a2bd7e@huawei.com> <20190528155956.GA21964@kroah.com>
In-Reply-To: <20190528155956.GA21964@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 28 May 2019 13:31:53 -0400
Message-ID: <CAGngYiW8Y3jt9ikb5e9LtfSkquZquLgB5iSRVXyka9fUXLrqYQ@mail.gmail.com>
Subject: Re: [PATCH v2 -next] staging: fieldbus: Fix build error without CONFIG_REGMAP_MMIO
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 12:00 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> You all need a better email client, mutt handles this just fine, it's
> not a problem on my system with my workflow at all :)

Argh, my bad. I use Google Mail -> Download Message, which does
appear to mess up the endings. Luckily, dos2unix fixes it up just fine.

For the v2 patch:
Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>

Thank you YueHaibing.
