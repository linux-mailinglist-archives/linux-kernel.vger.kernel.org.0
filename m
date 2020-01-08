Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA51346F9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 17:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAHP7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:59:53 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37764 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgAHP7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:59:51 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so3745796ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 07:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z4SW3YsZrYC7C7z4MOssIKys1QtDj3mTOPrqO+DqHxg=;
        b=jvRapN2z7Ugtj0mNucj74lU2w6NUWvODfZdVWa8Tp8XYxysb0PZ1Rw1lKxyoxZ9xtC
         suNyB0wDpdw7inNGYEIbN2R3ePE8Wd58r7cNorQYRbj0dtNxZMggS1slZHUIvcFFMCxI
         AtjEUxeVN8kLjOcvxt+1GzfS0bsmVkkvdJJ3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z4SW3YsZrYC7C7z4MOssIKys1QtDj3mTOPrqO+DqHxg=;
        b=OQnFJJIHzRMQ1SkFz51OjB70eKy4VHLO/w/Wj/5iSpvcwIoeRw9cJtqleV+mApJrfJ
         IsFrgC1hVR0O9U0Bnjw1nbQUvjvjRJkSBeP6quWCoffPi1Ysi//T5xHDuFVG6mbh64Um
         kC9wGS9cFHjrNyTDHpxiC/30VEUP/iD7Oc2Svf16sbd/S1iFupD3nEP+EZCFc3TVl9gB
         9MVveW50LuTHx4TI5/PfS2A20A+7ZgyCa9VuV2xN89TggVxX57gko8lcY6u0XqCKayzx
         wDpJeXJaAOaxAYdd1Cu6+Wc4D71O+CIge+OvwNoZsvUiDcwrge3pjonvXZ8H7gU6zcfx
         Q5HQ==
X-Gm-Message-State: APjAAAXXPg0kvnnexpd6pHVLUYXl4gvSTe5EeMHnBW4+IYuq02juAH3S
        as3S3UcTVQChFMr5z0dGUmBC/w==
X-Google-Smtp-Source: APXvYqzSlNuC5lEYE9FiIHbPFA28K/XJ1x2M7+aAVqW82lIcxqkbcPkENEfm4zk+rJ7wyQpCYgayeg==
X-Received: by 2002:a05:6638:618:: with SMTP id g24mr4669791jar.87.1578499190795;
        Wed, 08 Jan 2020 07:59:50 -0800 (PST)
Received: from chromium.org ([2620:15c:183:200:5d69:b29f:8fd8:6f45])
        by smtp.gmail.com with ESMTPSA id d12sm1079889iln.63.2020.01.08.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 07:59:50 -0800 (PST)
Date:   Wed, 8 Jan 2020 08:59:48 -0700
From:   Daniel Campello <campello@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Crews <ncrews@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] platform/chrome: wilco_ec: Fix keyboard backlight probing
Message-ID: <20200108155948.GA47901@chromium.org>
References: <20200107112400.1.Iedcdbae5a7ed79291b557882130e967f72168a9f@changeid>
 <ab377eeb-f1bc-13c2-8bbc-ccc53ecb7c4d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab377eeb-f1bc-13c2-8bbc-ccc53ecb7c4d@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Wed, Jan 08, 2020 at 11:38:58AM +0100, Enric Balletbo i Serra wrote:
> Hi Daniel,
>
> Many thanks for sending the patch upstream.
>
> On 7/1/20 19:24, Daniel Campello wrote:
> > The EC on the Wilco platform responds with 0xFF to commands related to
> > the keyboard backlight on the absence of a keyboard backlight module.
> > This change allows the EC driver to continue loading even if the
> > backlight module is not present.
> >
>
> Could you explain a bit more which is the problem you're trying to solve? I am
> not sure I understand it, isn't the kbbl_exist call for that purpose? (in
> absence of the keyboard backligh module just don't init the device?)

kbbl_exists is intended to return a bool based on response.status !=
0xFF. Without this patch kbbl_exists will fail and return an -EIO
error on any value of response.status

>
> Thanks,
>  Enric
>
