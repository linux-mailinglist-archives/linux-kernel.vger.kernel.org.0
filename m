Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A216572026
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 21:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391717AbfGWTf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 15:35:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34595 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388808AbfGWTfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 15:35:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so22939307lfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UmWmMtraSOxjxBJz33/xjrLbC0UGEWFvv/ghDIHiyOA=;
        b=lizIZxlhphLoTF4uQQbTETJ5rXzV610wEj6hzSajDuTSre4LpDLTyXdgCOnkHptl5u
         /5jSDXHgXwFcXmP2aBlsCe2EDPfn3y7qNcnHwnjsuqlp2NIi8+UKen3fGkJkM569r8IQ
         XgEBIBEg+fVAk6GjZYBRA6EyVx1uzN533cpHNEgsoGxGLvX78eiTBbfPWGqDRn3hNXme
         4HIsynwRr9aUfBUaK1odamf/4qcsre4mY7WMs4x9aYd8/LqfdRcFPZSxklbnmeyxAl9v
         mXVgAgyuVzQgRh8gN7OVVjleXjgBWh2HQvD6FS/Hm0d99c3UntWizlvLshzy4I9Jg0hP
         Fi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmWmMtraSOxjxBJz33/xjrLbC0UGEWFvv/ghDIHiyOA=;
        b=easHHthfEcnMlPASuQD6VqmSbrm6HCA2Qm1N0T1KvDMQaCP5yIWrNdheft7wqhXGdb
         zprSsjhDh4SLo8+YzdML1wYyyb3lyaC2LNNB0XEgKWBdUdemhvJRFcTrd7Qrh2oE7YZZ
         Njh8o4rkUk/rSLoOuyH3ooGEB1m4NCuN8KfgQ69OQTPmXy5CDUEOuL2SAMMUKF+bw81g
         8OvrnTeSPZM3i/g3uELwRlsqRdAuxavyq5rIFNTXH7OHjXSRoJC25vD9ywt76ndQj4Xs
         4zZ8W2Bv/VX3Y7fCP13QyT4Sey3jfLS0smR6E8VOExIdopi0l47c0dpB0BjJx6KH0YKb
         w0Rg==
X-Gm-Message-State: APjAAAV09COnejaRBiEoM3Fob1ruv/4RV7qRaKgqJx68tq/Z4dlWqfdu
        uYQNAe0zaRf44/qSmyQAtUhyrWVoPV79/sB8RQY=
X-Google-Smtp-Source: APXvYqxlXzwqS8wLBujBMtn6sfETd44rGe4jTio4gJGotxf/5FnDaaauyqDgwEaFGTquCfJHlamRbFVI3FZI0M932vA=
X-Received: by 2002:a19:7509:: with SMTP id y9mr36000075lfe.117.1563910523529;
 Tue, 23 Jul 2019 12:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190723192154.68114-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190723192154.68114-1-andriy.shevchenko@linux.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Tue, 23 Jul 2019 22:35:07 +0300
Message-ID: <CA+CmpXs7gTB9wuJm4rJiw3uW60gDhBDF-j0Cssn_=ggGjS_9Hg@mail.gmail.com>
Subject: Re: [PATCH v1] thunderbolt: Switch to use device_property_count_uXX()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 10:21 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use use device_property_count_uXX() directly, that makes code neater.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Yehezkel Bernat <YehezkelShB@gmail.com>
