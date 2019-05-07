Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8189516C57
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 22:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfEGUjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 16:39:25 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38703 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEGUjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:39:24 -0400
Received: by mail-lj1-f176.google.com with SMTP id u21so6410677lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iGjiCyI52fV+hV2sdyq4KdXVwy1tUzcVlMWIvb+/v8E=;
        b=PP+HkZqys3Q85gfVGQzWLlgGIlXK/yKDLHcrh9Dhut1Lp2SIQgs+ge0N8Yp2O8rLfH
         91a83kO2XTf17RRp0mDiBksy4vwI8vxH3XDNuc9PXiV11utghOAj3ooed5nJCCG53RAL
         wVkbrc6CsgASwijlUqwyry0dm7MUyMVNwHjuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGjiCyI52fV+hV2sdyq4KdXVwy1tUzcVlMWIvb+/v8E=;
        b=gAxRvx8mc2qXdLHMQTOFbgCLMIT4RAco9OvHHlzHxRAb4H07Ner1jvio7PjHcIcXEy
         yG4ZwnVDsMnOQuD7s54jEh+7IhMatmF1WjpwefmcidbQ8iSOsFS7H5UWbFTq392+FkV2
         CCkyCaKNch/TdUu6SS59W+lwOFmQ1n3dz4I01ElO01qszfaQOe/cJShPH/fw9KfZyWOX
         Us3oMcOhSOf6vvUnGFJCYzYG2wRywIOW8j/tWHobcsvYwHywuiUbl+gkrn4XGXk6dU8q
         7kkSk3yijbPLQtigrgwEcoy7lGLONYE9HYRj/gL6eh3uYprYhRfQM5v308MzGf5qO8wt
         IiZg==
X-Gm-Message-State: APjAAAUgOrXY2vClA0atL5eVxlVGA0OPPWqmFsgaYrcWMjkEPg4jsK86
        qaY/JhK53PgyBH4sD6MW2Q7G8yDHkco=
X-Google-Smtp-Source: APXvYqxNmRTJEY8/G+IG88ccfo7SdoF0N+xHIRcR7Uy7P2qrxn8/eS3BfajSjpNF84OC4XZP9+YOXw==
X-Received: by 2002:a2e:858b:: with SMTP id b11mr17964146lji.176.1557261562235;
        Tue, 07 May 2019 13:39:22 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id f25sm3485154lfc.46.2019.05.07.13.39.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 13:39:21 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id z1so3326897ljb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:39:20 -0700 (PDT)
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr17683990ljq.118.1557261560657;
 Tue, 07 May 2019 13:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190506123659.23591-1-christian@brauner.io>
In-Reply-To: <20190506123659.23591-1-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 13:39:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh692HhZ+s=WWCw81mWFvXEGpXKccHcmpRUrO9p3KKD=w@mail.gmail.com>
Message-ID: <CAHk-=wh692HhZ+s=WWCw81mWFvXEGpXKccHcmpRUrO9p3KKD=w@mail.gmail.com>
Subject: Re: [GIT PULL] pidfd patches for v5.2-rc1
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, David Howells <dhowells@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, and this causes "git status" to mention the

  samples/pidfd/pidfd-metadata

file, because you generate it, but don't then mark it in a .gitignore file..

           Linus
