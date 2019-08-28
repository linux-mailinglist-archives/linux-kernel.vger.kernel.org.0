Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2650A05CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 17:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfH1PM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 11:12:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35264 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1PMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:12:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id d85so10705pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 08:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=XcJ6NYlg/uL9WmWriXAoX9eMie6Q9zQs2ri3z33W8Do=;
        b=B2+UPSog7z8YLILm6YZplhJNxIH5DioVNm5Whk2+ecAMQWfM0n77Oz3Ge9I8H/Vpti
         z6bzqGN+baAi0yG18A2r5n2QkdsN3rtnXK/XfCMIizgEIY1jHvCBz01TICGm4RMM78OP
         xKiIL4fyqd73KHRwzu9Eo2PqQvL5qbVvdv/hI8g0PfQuP5jlQg3l4juQvANmy6I/MKXU
         uDQh9BAq/H88QsdenOLMwPYExjsjktzeUbybwynwBrdnzSmr8LimKn/fFKjG89VIAZb3
         g/pB+GdmD9Z0iurJEiuMYQXq/MYUV6eU20W+ajDVpS0S5SBMVuTNd1VlmB99/FSmiEKX
         cXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XcJ6NYlg/uL9WmWriXAoX9eMie6Q9zQs2ri3z33W8Do=;
        b=G8s4U8saiQaN/1AfcBe259jcwC/nRQWzlEmj1kBPDO/kB++bqc8640okM+v/9qU9TA
         7DfKYWK9j+xVRcKmZ2CVFvhxy6fO3s7EyPaEx3Em5+yvNGQ7dmlKGgTX9C4/lN7q4jsc
         guLCa43SQU9Z4wmckmoSfNL9YmWA9Pb5XkRBC60ss2QxmWDLWCy9QbYBDXMs3gbC+CH/
         tn+khJWQirk38sLGJ5rVXq0ce26765dAdDGtlz9Tj3UIxT4Zu86zof0JdnNBGuaw4+cP
         I2zoyGvWmFOLZ1qR/x5JwWMWIPrEUeAjcOOQwok/8uy2TgJ+Z+Ss9YIUqZwfav0yjFf/
         jt+g==
X-Gm-Message-State: APjAAAXHhxp09Zv+spSVZasDx3RzZ2mL6EkOdl83F9nrVeFyY4bvkBlf
        XnMSra44Wy+KnkZpz3v1IYZD+lEqAaY=
X-Google-Smtp-Source: APXvYqz97Mimt+J42SvRSibm4RDZVnMCd5grLb1uXWfEqZeh5eyLN9Msos0FMr0J7qZbOn21/oz1ow==
X-Received: by 2002:a63:2b84:: with SMTP id r126mr3994757pgr.308.1567005144906;
        Wed, 28 Aug 2019 08:12:24 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:cc35:e750:308e:47f])
        by smtp.gmail.com with ESMTPSA id l31sm6950443pgm.63.2019.08.28.08.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 08:12:24 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/meson: add resume/suspend hooks
In-Reply-To: <b8ea00c4-3749-e571-edb6-ae5091b23247@baylibre.com>
References: <20190827095825.21015-1-narmstrong@baylibre.com> <7h5zmixvrz.fsf@baylibre.com> <b8ea00c4-3749-e571-edb6-ae5091b23247@baylibre.com>
Date:   Wed, 28 Aug 2019 08:12:22 -0700
Message-ID: <7htva1s4rt.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 27/08/2019 21:17, Kevin Hilman wrote:
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>> 
>>> This serie adds the resume/suspend hooks in the Amlogic Meson VPU main driver
>>> and the DW-HDMI Glue driver to correctly save state and disable HW before
>>> suspend, and succesfully re-init the HW to recover functionnal display
>>> after resume.
>>>
>>> This serie has been tested on Amlogic G12A based SEI510 board, using
>>> the newly accepted VRTC driver and the rtcwake utility.
>> 
>> Tested-by: Kevin Hilman <khilman@baylibre.com>
>> 
>> Tested on my G12A SEI510 board, and I verified that it fixes
>> suspend/resume issues previously seen.
>> 
>> Kevin
>> 
>
> Thanks,
>
> Applying to drm-misc-next (for v5.5), with a typo fix in the first patch commit log:
> s/suspens/suspend

Is there any chance of getting this in a a fix for v5.4 so we have a
working suspend/resume in v5.4?

Thanks,

Kevin
