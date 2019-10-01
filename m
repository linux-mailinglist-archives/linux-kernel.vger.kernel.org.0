Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA54C40C6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 21:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfJATOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 15:14:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42940 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfJATOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:14:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so8752036pff.9;
        Tue, 01 Oct 2019 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9bQcsJ17lYCiIijlkWSB0Rqxgr7cc1Fcv0k0NaxvXaE=;
        b=g48xqbtWXL0UIDVkSIXX3Sk2sQPYSjgvHFFr+gt0IloT/2hT7UQGOFpQUJ4gl/fpOD
         xyaqjJnnNBRUXWTgWdmCPJshSDpkvTvhktEyz8QNAg7cMOGee3aKGviSAlntA0mfBbJm
         ms6+n1YIDBDQycDmsQ3w2MIaQkehUos8gfMK3UBcrPFzOXoWAXWSc530KFZdry7RM6Gi
         YJnLjEx4m8o+16PE+Rb10XGyRU7S9lLlZPODCf+nDmgQZY8qn4khrHDGGXnQ/Oxp5XIA
         GenBbh3b+N52YxJhlxqXG5cFZXczApmphpPghdTwy83njnT71NVyt29XGsjYuRyzY/LW
         cxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bQcsJ17lYCiIijlkWSB0Rqxgr7cc1Fcv0k0NaxvXaE=;
        b=T7i2rC9wMZfwYOmK3zizw81ayQCQBgCBEExDiWwEuFG7GW3KwVpcrtz3TuoGsXOtyW
         TnD9vfMttXRnSjcEvvW1+09XG5f5/pNhI7oPffel8x+0JA2zqC1l2A16dn2Mozw7IZdd
         BRd+Zo0C6BSKd4likRqYuR3LGRhtSa0xe+eCnktA1ATXnkRnJZnKm23hIwZaXk3Mr2dt
         PouZFUvB1s+TwiM04SlA6xSc0oic3kK/R/pjJSLEogMm/G87ZmBAopNE4g8T84aPQ/n7
         ikeQuodz7anu+w27Fc3gx5MxYKliysF13Je0rVn+yB71SKA51owLDC9LIoz8jdMZILne
         RTXQ==
X-Gm-Message-State: APjAAAWLxeCl7thgRGFahDDPJRBZuOy21xgi8o4PgNjKNlpYW2zqGCt5
        EhSqYFZW7icQ9qpxBNSMGe61RnlMLuwbZA/9gPjBYs2bhPM=
X-Google-Smtp-Source: APXvYqyNBGbiR21TBJJP5b6s6nYlDdJfRoJF5dCJCX05G314HglBuUKlKfVOVbyVwXbHcIrm25QQTl8ovJpC4uAHaDQ=
X-Received: by 2002:a63:170e:: with SMTP id x14mr31605996pgl.4.1569957246718;
 Tue, 01 Oct 2019 12:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191001185822.GA48020@dtor-ws>
In-Reply-To: <20191001185822.GA48020@dtor-ws>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Oct 2019 22:13:53 +0300
Message-ID: <CAHp75VedN8BCgkFHx599LRU-mFqm451Lz5OJtOU_x5rQWMSKPQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: peaq-wmi: switch to using polled mode of
 input devices
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 9:58 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> We have added polled mode to the normal input devices with the intent of
> retiring input_polled_dev. This converts peaq-wmi driver to use the
> polling mode of standard input devices and removes dependency on
> INPUT_POLLDEV.
>
> Because the new polling coded does not allow peeking inside the poller
> structure to get the poll interval, we change the "debounce" process to
> operate on the time basis, instead of counting events.
>
> We also fix error handling during initialization, as previously we leaked
> input device structure when we failed to register it.

>         if (obj.type != ACPI_TYPE_INTEGER) {
> -               dev_err(&peaq_poll_dev->input->dev,
> +               dev_err(&input_dev->dev,
>                         "Error WMBC did not return an integer\n");

It seems it can be one line now.

>                 return;
>         }

-- 
With Best Regards,
Andy Shevchenko
