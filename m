Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C04E16C011
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 12:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgBYL4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 06:56:48 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44961 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBYL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:56:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so11771056otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 03:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4F3T1pM37h27ltU9k9yDPyuOsl3lRH1C/Wcw75sxknc=;
        b=p3LU5TbqY5xN/ik66fv+e0RRzcD0MeKuz3WyueYlhkJRgsAW9hGv/u/Ems1Vm55R+D
         FoeCwxfbmNRN7lXUTpZH6NxLpMGJkzzt2mfD0eREcxGX3jx7T41jhPvxs6Cn23ECsYAe
         e2/+l+s+pL1RxvvTX6oySxiiNHroACZG0DbnaeOYkf1QXk5+YLo+dgrOa4fSvnPWP9Fm
         rAsMERiuPJ2IhgGLUgvWQXTYg3LY6mH1QK5we6NNOZLW+S/JvqAvZKoa4U6iUxgiO1RN
         xk7l2ZZQXuO3MRA1a8RfjlRfGhVAsviCMr3bv5YNKGhRfMTcWGptJ7cBZeQu+tnTP9bG
         /D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4F3T1pM37h27ltU9k9yDPyuOsl3lRH1C/Wcw75sxknc=;
        b=uSszjYa6AG712PLC6889r5OjazVsM7FTgGygKGI4YQxXh5FGwIIa/w7W/UbjO7EDBh
         DuQ2ik+RGLtVSXY4YqNk0CjwwsfV8uY+ZdUlqXBVuMjYRra4gEbMNXSYQeNaOF4m8R1Y
         kNzLb9caQ/HbYQC8aUcSLKeVYxOilwoq1kTLd2NJlkrhoBgnrFZF6KIh/2myZGrv/pMh
         MITXPZPBYeGRzhBj9V8C6RZtJiPWfNqSkiwihqQ0dmZLAdnTWvRP9GnkcncjLnVrJdV4
         I0k91G7w7Vq+mxpwrbf6hpZno0nyDInvCYjFdiyZYScqQ2bCiaybRhhRRO2EV0KP+dAm
         VAzA==
X-Gm-Message-State: APjAAAXU1tBc708A5I2NWF1qiBMEdqwSr2uBIl8kR4pzHbcKAynVZkx6
        i+Jwzol7vg4lsOOhQVWLgCYDvah+Y/UzpyZPVFw=
X-Google-Smtp-Source: APXvYqz/KxkXiO93FGWhoqaxFQB9DKYLdNpPyaNkpGGExAZzE4/m/uk8hVRJfhxepSJMMm4Y2qiGe71Iv+uTUadrOEU=
X-Received: by 2002:a9d:754e:: with SMTP id b14mr28525076otl.59.1582631807140;
 Tue, 25 Feb 2020 03:56:47 -0800 (PST)
MIME-Version: 1.0
References: <20200223231711.157699-1-jbi.octave@gmail.com> <20200223231711.157699-29-jbi.octave@gmail.com>
In-Reply-To: <20200223231711.157699-29-jbi.octave@gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 25 Feb 2020 13:56:04 +0200
Message-ID: <CAFCwf10qrkzfBTfXo0wzDKPjaVRw7Nyjk3Ukr0_er-jBgy8ptg@mail.gmail.com>
Subject: Re: [PATCH 28/30] habanalabs: Add missing annotation for goya_hw_queues_unlock()
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomer Tayar <ttayar@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Dalit Ben Zoor <dbenzoor@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 1:18 AM Jules Irenge <jbi.octave@gmail.com> wrote:
>
> Sparse reports a warning at goya_hw_queues_unlock()
> warning: context imbalance in goya_hw_queues_unlock() - unexpected unlock
> The root cause is a missing annotation at goya_hw_queues_unlock()
> Add the missing __releases(&goya->hw_queues_lock) annotation
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/misc/habanalabs/goya/goya.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index 8ca7ee57cbc1..6138b461d0f8 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -5081,6 +5081,7 @@ static void goya_hw_queues_lock(struct hl_device *hdev)
>  }
>
>  static void goya_hw_queues_unlock(struct hl_device *hdev)
> +       __releases(&goya->hw_queues_lock)
>  {
>         struct goya_device *goya = hdev->asic_specific;
>
> --
> 2.24.1
>
This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Applied to -next
Thanks,
Oded
