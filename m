Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F06F147A35
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 10:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgAXJQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 04:16:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55914 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730287AbgAXJQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579857413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVwp3U5GzOX2o0jWqVHj3WHwgjI/zlg9dOk4xt7JmuA=;
        b=VQOkVf103fQn8r2Iy5fiqFBIMOqqer1SkL9v9y4w8NF9hT/dA+OeXhMEwlCaR/hecFS5Jx
        EV9gwXK/uBV6SMHq8oFvmbRxwY3PgitLDIlkCJPoX+bCD/u82VPrSF21z5RrCjGIj3ZnIR
        Ib6sXLf5CY7iKz+BHjaTRIzbn0IcbzA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-1Q_BTgs6Mj2Nl56QR7PAPQ-1; Fri, 24 Jan 2020 04:16:52 -0500
X-MC-Unique: 1Q_BTgs6Mj2Nl56QR7PAPQ-1
Received: by mail-wm1-f70.google.com with SMTP id p26so288230wmg.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 01:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eVwp3U5GzOX2o0jWqVHj3WHwgjI/zlg9dOk4xt7JmuA=;
        b=r8RB6D9JcCfceRWEiG/Jzvji0Nqq3mPPRltrU7QWIv0BvFAnIrliZboxapIeNfylVx
         N3qysFKJYtDv3mc50IFT3L1EGiltITTePmyRgKSDk838Kc+F+sUNlF1T89FjnXBRFaz/
         inPxM3MOeMaoSwUdhRTwmG0bXDs5ScoZrOjl3t/S7IQzQen/1Fgno2G4YLPQV7aCADvu
         NFvgaORoeq622VjDpFfKOfd0Zj8FaQgkH8LkuEN7YS5zxKGrGCGfef9wGl3GVqePnHzz
         w2K3qgVBZAqoMb5WE3Nij0/Fd9QfUwV21Ekfw7kml64gB0Zt33qIb+CpxGyh7QKCEHvv
         yGwA==
X-Gm-Message-State: APjAAAXZrbMhS8fjWNas89goB84mB1eypEjXCK2tG1iKPZSikPQucGpo
        hO5JhD8qQ7wfK1V+TQsK0GUsXyy/cOLsEYr0mPWzzmAjN/uSVU7rEm3VUOgvuC/ciTTI/NiobCQ
        4NQI2WWIo4v+7ESD+fAZ8PkLD
X-Received: by 2002:a1c:a445:: with SMTP id n66mr2460521wme.151.1579857411356;
        Fri, 24 Jan 2020 01:16:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUiU565WJyxONGgI7w4xQRq/ENXZEynENvjhqk4CBvmo8g5IcgWmw96rLrMcfuNGJKf9m74A==
X-Received: by 2002:a1c:a445:: with SMTP id n66mr2460489wme.151.1579857411156;
        Fri, 24 Jan 2020 01:16:51 -0800 (PST)
Received: from localhost.localdomain ([109.38.141.136])
        by smtp.gmail.com with ESMTPSA id a132sm6060770wme.3.2020.01.24.01.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 01:16:50 -0800 (PST)
Subject: Re: [PATCH v12 03/10] firmware: Rename FW_OPT_NOFALLBACK to
 FW_OPT_NOFALLBACK_SYSFS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20200115163554.101315-1-hdegoede@redhat.com>
 <20200115163554.101315-4-hdegoede@redhat.com>
 <20200124085751.GA2957916@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d25d5d6e-0348-b19f-539e-048cfa70d6a6@redhat.com>
Date:   Fri, 24 Jan 2020 10:16:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200124085751.GA2957916@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/24/20 9:57 AM, Greg Kroah-Hartman wrote:
> On Wed, Jan 15, 2020 at 05:35:47PM +0100, Hans de Goede wrote:
>> This is a preparation patch for adding a new platform fallback mechanism,
>> which will have its own enable/disable FW_OPT_xxx option.
>>
>> Note this also fixes a typo in one of the re-wordwrapped comments:
>> enfoce -> enforce.
>>
>> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> I've taken this in my tree for now in a quest to try to get others to
> pay attention to this series...

Thank you.

As mentioned before I believe that this series is ready for merging now.

Andy Lutomirski had one last change request for v12 of the second
patch in the series, specifically to replace the loop searching for
the prefix with a memem, but the kernel does not have memmem.

Andy, are you ok with v12 as is, given that we don't have memmem ?

Assuming Andy is ok with v12 as is, then to merge this we need
to probably wait for 5.6-rc1 and then have the x86/efi folks do
an immutable branch with the first 2 patches of the series.

After that you (Greg) can merge patches 3-10 (after merging the
branch) and the platform/drivers/x86 folks can take 11 and 12
(also after merging the branch).

Regards,

Hans

