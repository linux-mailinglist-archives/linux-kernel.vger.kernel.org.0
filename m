Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A0017AF8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 15:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfEHNqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 09:46:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35410 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHNqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:46:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so9972920plp.2;
        Wed, 08 May 2019 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0vV4CXgxZrxMQI39HyAbLAuE39R1lIDGlJLQVLUiF4=;
        b=C8cY6XrZEN+XwJeq8JGQToBjLffxQEdVeDyR1/+FCVSPVbhn2S1gSCRDQW9BpzMksx
         nzXiYSBE8JQr45neyIp2zmUemrmjW2NYN6FlAkunL5lrZvlnj3g2cwjzX1Bj+nGhYe20
         MyDXWWttDreiuqfIUSCbXThlNW4wYNCJSq2s+P/IHoHnmOhwKo2OzFePhtv1Clmysa3A
         5Lq0h2UK7CWeTCVPZQwpFHzwYdRWyVLUg48xJYOb1/ZQXXxEoGuqJXgzU58IVNmk8o0i
         cbnY1nPbsq6REpWJzSwvCQXGkYq2qMSdf/qOQSMQK4oHtzCpMfIkTvob9XZGwhGH/ehI
         n70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0vV4CXgxZrxMQI39HyAbLAuE39R1lIDGlJLQVLUiF4=;
        b=AvKKwQvINESdbUuKGeZoG7HTXVElUlQjxTYDCLZ1OrOW7Qlo0sJIGZ4qWvxETvhHXc
         xrfrK4S+Qg+KzLoyukiAkS8LqDn7B0zLAgGZbAc5IFQLGCZg3c73u9A/DXN25EdCjJtL
         uT3WGvuVPvqvNVcmw3RoBRSGGxQ8mZqgOMPwP6AKNIRh8LR3oQ09p2QSuBFbGRL0Ty/Z
         B7c3B1PK/C2A43AsPyV0yIBrIJ+bBHvudWxzSMiiqhpntnAQI4bSO0/cxIFlsREYfeaz
         Fpds68pkW+scQwYHrsYktVZ8SQOZRN8r2ZISjPZzyPugj0wBo8hPyc2Vnm/YWd0y6Gy1
         G86A==
X-Gm-Message-State: APjAAAUwAlwv27kWhBCEm6zc4gDKqG80CeV+A01Y04TyEXw1kXy34vt0
        u3HrblqhdCcCnG2IhkKDAuIOHcixUByRR5NIeFCez21OQH0=
X-Google-Smtp-Source: APXvYqxL17budVzpiZOBUwNHLqNtvu5dXiUwnYm6Wq/ZeS6BNxu3DAOKksiPiNY9uKw4EEoHuSoVJteDRdsB4TbARK4=
X-Received: by 2002:a17:902:758b:: with SMTP id j11mr48233418pll.87.1557323173098;
 Wed, 08 May 2019 06:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com> <9a4351a5-ab04-2ebb-9961-1c50dda9800d@gmail.com>
In-Reply-To: <9a4351a5-ab04-2ebb-9961-1c50dda9800d@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 May 2019 16:46:02 +0300
Message-ID: <CAHp75VeWiP57iT_75F7mYNKAbBhxkzpBcWhJDd=tkVZb68uXgA@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] platform/x86: asus-wmi: Organize code into sections
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 1:12 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> The driver has grown pretty big and will grow more, which makes it hard to
> navigate and understand. Add uniform comments to the code and ensure that
> it is sorted into logical sections.

It does slightly more than described. Please, split out to the
separate patch(es) what is not suit to above description.

-- 
With Best Regards,
Andy Shevchenko
