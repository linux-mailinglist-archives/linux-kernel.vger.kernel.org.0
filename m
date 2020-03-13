Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB6F4183E24
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 02:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCMBBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 21:01:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53317 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCMBBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:01:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id 25so8199668wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 18:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2U6tAzdLF1x4vnU8NvQtzG93LtZx8bGoRnFmPfqzr44=;
        b=fbJPeQvIkVYKb9c1z7XgxRxx4/zfKwEcy6ajBhwUYxVUorFsSnvoInvgs6/KSmWLvz
         LdXzEIc4+V3XoENOHwR/e8OLYs4uvwpyncqQCDonDb+Oeak8teYTgUW57sGK8xMgpEBK
         P5bPncy48nsYk/HrlB2rCtcGyUogOalJxiMwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2U6tAzdLF1x4vnU8NvQtzG93LtZx8bGoRnFmPfqzr44=;
        b=T7UIZAyiBznNG62Jo/5s2LScWWnbv2HKjnRMF+o+CDzn10OBmtNxsyeNn/wNpvTfbv
         a6YBffAIIDmcRkjZW3gwnhuikUOGElkXOBDPunLqgt3+9pufkf7e4LqVZ9yu8N4k/ttc
         mCGWL9/8cfiT2TgvBuDbE2O4xHE9GitlIgeex9B5CCnFx2WZRaHyN23KnwhghnqySy3L
         /h3IWlV//QanycWjLmgRoiYecVY5gxZEnTJ8wdXab3ICp5iRks9bHxfHs5JuMBhGFSaK
         Pdc5pB/RmL+/KaCC0bL5R5/nIs+DJW3DlnhkNgFC+wCmXZLzAa7z1DwxFE4EQAgmEJ+E
         jnvA==
X-Gm-Message-State: ANhLgQ0LMtYpeCmhwK+OAlPPQhot583fmSI3fDqYm1LLjTc3T5nneeOq
        zD9V26XYXf6DItz3Qt1p/OLBFw==
X-Google-Smtp-Source: ADFU+vu3vr8f21ZL3B+XWi8+py7H/hfbmXTl27EUZLH/IAxHz0tps0u94v2tYSJjBvt8bj2pSUpGow==
X-Received: by 2002:a1c:a384:: with SMTP id m126mr7548567wme.84.1584061258757;
        Thu, 12 Mar 2020 18:00:58 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:fa59:71ff:fe7e:8d21])
        by smtp.gmail.com with ESMTPSA id b16sm75473908wrq.14.2020.03.12.18.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 18:00:58 -0700 (PDT)
Date:   Fri, 13 Mar 2020 01:00:57 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, viro@zeniv.linux.org.uk, shakeelb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/4] Support user xattrs in cgroupfs
Message-ID: <20200313010057.GB24320@chrisdown.name>
References: <20200312200317.31736-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200312200317.31736-1-dxu@dxuuu.xyz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Xu writes:
>User extended attributes are useful as metadata storage for kernfs
>consumers like cgroups. Especially in the case of cgroups, it is useful
>to have a central metadata store that multiple processes/services can
>use to coordinate actions.
>
>A concrete example is for userspace out of memory killers. We want to
>let delegated cgroup subtree owners (running as non-root) to be able to
>say "please avoid killing this cgroup". This is especially important for
>desktop linux as delegated subtrees owners are less likely to run as
>root.
>
>The first two commits set up some stuff for the third commit which
>intro introduce a new flag, KERNFS_ROOT_SUPPORT_USER_XATTR,
>that lets kernfs consumers enable user xattr support. The final commit
>turns on user xattr support for cgroupfs.

The whole series looks good to me, thanks.

For the whole series:

Acked-by: Chris Down <chris@chrisdown.name>
