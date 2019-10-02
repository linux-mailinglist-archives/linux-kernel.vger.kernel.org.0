Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0F9C8F82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 19:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfJBROE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 13:14:04 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41149 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbfJBROE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:14:04 -0400
Received: by mail-yw1-f65.google.com with SMTP id 129so6337039ywb.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isvX3eXp9HYRHix3Qz7Avg+A0LJMKh77nH1Ku9/2tnA=;
        b=nocZanzKO5o+dhkUoB6MTA2+n2fKLdMHfFVzPeWoIIKMGdREKyjK8IWCDz/yYtPhjC
         NecwBJh5HsUunx7YNllUqzzgo8xgPBrkvcgUvg/8GsiFIjvZXaQB1p364Wkoa7MNS1Qm
         /529VxKidohbxfGeDAmnNYmLT5YNEbI7Hw57IxUhjVCjJtqPYZAWV25QPfMTNnsfljUw
         f3JB0QT6zwJGo3v2Ng5RyoRi7dBHiLqMhArPjg5ovB/hD+WQgSjR1LBr6SsdCXCYc3/S
         f7CKQzNWu2E3bA/EHhukbSE528gZHXWZpV/wsmV8aqbvnB/WvMW9nnZzPWQZlIZZizfr
         BqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isvX3eXp9HYRHix3Qz7Avg+A0LJMKh77nH1Ku9/2tnA=;
        b=eJL6n8di7pIE1UEdzGLmgqeqieZM4vZQbrPn6svdMIsBnZjUVTA84rvd/jd+JyGsSt
         4ImvLaWX7ypcrBBhNdcepDi7N/fXxuI3KorBHP3QddL+Y34SK0FD8NSsWXWOjCrBgX+G
         P9l2dSbYLO5I6zPnETb6dIS1pmDQxfzH7zI80dhGmVJ0h0QhMKg9qvpSE6auLF8Kt5Ki
         GDxUxtsYxmiCQJBw18bV2BoKzDMUHcI2K066IVjVs5u6/fve8BXgNIxMjwb9bAajcawU
         iBZT1KGDSstigLjT9aKBhTehoHPrJz+bdc9lmadN//Bkd+4KK9+zSshV72/WLBI+OQGI
         VsAg==
X-Gm-Message-State: APjAAAW6uvsew9lIjonnzJYNpInm5ahLiba/gNV5iHnnCD9N/VSmIEzL
        wEzKG1uPPMjFlIifzNtpG9NVutkwMLj/w8EB8QyrWQ==
X-Google-Smtp-Source: APXvYqxNrcfrNH/xcd61hCMBPnlquQ4F/Zs0WRYrG0173J3rX+ofXbc29QqVkRLk9iILT609t85YZffktNfehz5HxXc=
X-Received: by 2002:a0d:d1c5:: with SMTP id t188mr3498817ywd.265.1570036442799;
 Wed, 02 Oct 2019 10:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <20191002094650.3fc06a85@lwn.net>
In-Reply-To: <20191002094650.3fc06a85@lwn.net>
From:   Mat King <mathewk@google.com>
Date:   Wed, 2 Oct 2019 11:13:50 -0600
Message-ID: <CAL_quvTNvnusdercRJhdXYDzBB=qy3cTrsPAuJSpE_tpWhnCmQ@mail.gmail.com>
Subject: Re: New sysfs interface for privacy screens
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Alexander Schremmer <alex@alexanderweb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 9:46 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Tue, 1 Oct 2019 10:09:46 -0600
> Mat King <mathewk@google.com> wrote:
>
> > I have been looking into adding Linux support for electronic privacy
> > screens which is a feature on some new laptops which is built into the
> > display and allows users to turn it on instead of needing to use a
> > physical privacy filter. In discussions with my colleagues the idea of
> > using either /sys/class/backlight or /sys/class/leds but this new
> > feature does not seem to quite fit into either of those classes.
>
> FWIW, it seems that you're not alone in this; 5.4 got some support for
> such screens if I understand things correctly:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=110ea1d833ad
>
> jon

Thanks Jon, I had seen that as well and I should have mentioned it in
my original post. That patch exposes the privacy screen using
/proc/acpi which does not seem ideal when adding more privacy screen
support into the kernel.
