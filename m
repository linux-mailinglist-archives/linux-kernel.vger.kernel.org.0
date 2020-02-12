Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36938159F73
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 04:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBLDH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 22:07:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37858 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBLDH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:07:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id s3so676788edy.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 19:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFLoJ+Iscn8Qb8Jf6d+3iR2+svxKe9mFdKwvUsh5fhM=;
        b=wE6p7gn51MRK87tVTxdIg0KTgY7b1uGXoMWElvxJiFG4fDFHIox7jf3XfT1A+lguat
         /wlazP6U6/5qjsr5XlZXf13lV4uRoIpHVVI9TpxM/UsCUy4poALez1jSo6rrE9cnfVgl
         TXW4QoMlNLiDCJA8z+e8G/tWx9I9Qvj/ku625Ew0vzecoa8+kmqyhN4o4wYojFfW8iQF
         GiALbzBC+r4wMWzJIGRq5aw2z1gX6VgpQ4Dny4ry1WQuV55aKdrq9EBAnsFr1NSXdu+J
         FsvQBtl1gXiApXxaebax9SZCalClDyZbdp/T2DmExdEzMtDQ3cf9DHSxA4LLviJcOjQr
         n5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFLoJ+Iscn8Qb8Jf6d+3iR2+svxKe9mFdKwvUsh5fhM=;
        b=BSPpu9bUfi0Q7Fnz6AO65fOWDu/RrUb22hZl0Q4MRtxjIEy1LZBQ3Gp8I19beRRc28
         Nt/Ju2yEd9uXvj7V54gdI8R1pghy8BSOFu8IeTrcRMM2Mifdd/DQPI4HV2SkVLLu0XXD
         wpKhNBUIwxDkV5OLoOHbLZfzg52qgND9eIfXG/idIfpwtPguaB7dLkXC1Vgt5n9+JrA4
         eQQyMbYWiRHtKXFTbDx0I0g+rK/5rXvlFpeh0ghG+8NDs7h4vQTon9mlc+hfn39koZaL
         iv/vaUGDU3+Nj4RAoGgn5EX5Z3G3K92YZiFjzT/SmzA1pljq52sdj4AHAXAbm5j7cDBf
         tQng==
X-Gm-Message-State: APjAAAWTM2tSEyIH/uWm0gDvujpQ/hIPG2GYXqcK2T5DPcUDE6D2KXw6
        ncD2iwjdIxtbMCLfjRbnRQClQduhaivBM/iCsVhU
X-Google-Smtp-Source: APXvYqxDmrFQjx8V0VcmOGrFMs/oVT1r+vBxUCOfebdEY0DJ2CPe2Z5xwZqWoVHs9cbihwVvLdyo1+WzRoz2TnBYYbU=
X-Received: by 2002:a17:906:22cf:: with SMTP id q15mr8786331eja.77.1581476846571;
 Tue, 11 Feb 2020 19:07:26 -0800 (PST)
MIME-Version: 1.0
References: <20200207180148.235161-1-smoreland@google.com>
In-Reply-To: <20200207180148.235161-1-smoreland@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Feb 2020 22:07:15 -0500
Message-ID: <CAHC9VhSiNMEXreCb9=M-Dy=8HOyGRobnBVBMYTHOL1W39dd--w@mail.gmail.com>
Subject: Re: [PATCH v3] security: selinux: allow per-file labeling for bpffs
To:     Steven Moreland <smoreland@google.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 1:02 PM Steven Moreland <smoreland@google.com> wrote:
>
> From: Connor O'Brien <connoro@google.com>
>
> Add support for genfscon per-file labeling of bpffs files. This allows
> for separate permissions for different pinned bpf objects, which may
> be completely unrelated to each other.
>
> Signed-off-by: Connor O'Brien <connoro@google.com>
> Signed-off-by: Steven Moreland <smoreland@google.com>
> ---
>  security/selinux/hooks.c | 1 +
>  1 file changed, 1 insertion(+)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
