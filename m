Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA0FD1734
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 19:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbfJIR5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 13:57:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41998 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfJIR5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:57:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so3388849lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8boM57nsIRzYbBpN0Z2Y51IdQe2gX/7UPNvVMmUq/U=;
        b=h0bAzS/dV9bQ6OnmXiwCK9ZIyyBp1EgxxpfnZdS3eiJkJ4Cjz7v9qeZ5N91ha6cYYN
         sdAGRVz3vOBIiPXxDatCim0mPu9JCDWAHWzCx9srQuMd9i2Of+bFJ7pwT0s3HSW9A+uI
         g3PA1uiN+F7kYnzzhfntyPIl5pCuME5B6pPLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8boM57nsIRzYbBpN0Z2Y51IdQe2gX/7UPNvVMmUq/U=;
        b=rW/gcnwp/ioCRlYeZ2lKIM1wd7aCD5BkWK8E5RtvnyzzEsVdD7UpOA8wzJ/Q9kh+jm
         s8XzP0EtfsXfahWLcmMPwxEOPQ4wn83/G9IJnIAIut9aYaPj0oeU15LgWC5Vozp/s6tO
         1ZUhTNCvXS50XmunbMRnimTbb3bQpLz/wYmNts2uKmmDXdnbU2oWKanhUrptX1h3FBqk
         I9+R3abvQPfl2xkg//L+f3RnKvDBk2VQ3s09NUufjSah3uOGzwpmhdrmdvslGe2Dqnhh
         ZSnjhVUK3Fzu8BgaZIudxHZWuNbgsbcjj9I9s4yx6v4csOHfHGDnqgLmQmP70cuwy2kA
         Nw8A==
X-Gm-Message-State: APjAAAWFmg4iae47gUvtFQ/SjicXaM/yXenfIfYaQUuN2FxBNHnUZJW2
        wxaCHSNyzUS8FObD3+VztDnL9wExRpg=
X-Google-Smtp-Source: APXvYqxJSAq6TpMAL8MjpklCtVR3jykTta/LD0IAxDxH1shGEXEOGEFObFk1AMjeCNi2BmsZ/FxK7A==
X-Received: by 2002:a2e:750c:: with SMTP id q12mr3138362ljc.138.1570643835036;
        Wed, 09 Oct 2019 10:57:15 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id b67sm647463ljf.5.2019.10.09.10.57.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 10:57:14 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id v24so3438520ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 10:57:13 -0700 (PDT)
X-Received: by 2002:a2e:9848:: with SMTP id e8mr3209250ljj.148.1570643832712;
 Wed, 09 Oct 2019 10:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191009170558.32517-1-sashal@kernel.org> <20191009170558.32517-26-sashal@kernel.org>
In-Reply-To: <20191009170558.32517-26-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Oct 2019 10:56:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVe+nxotYXExXRxhvCSTCqyRuZUto6UrvR2oHfeGrJ+g@mail.gmail.com>
Message-ID: <CAHk-=wiVe+nxotYXExXRxhvCSTCqyRuZUto6UrvR2oHfeGrJ+g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 26/26] Make filldir[64]() verify the
 directory entry filename is valid
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 10:24 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> [ Upstream commit 8a23eb804ca4f2be909e372cf5a9e7b30ae476cd ]

I didn't mark this for stable because I expect things to still change
- particularly the WARN_ON_ONCE() should be removed before final 5.4,
I just wanted to see if anybody could trigger it with testing etc.

(At least syzbot did trigger it).

If you do want to take it, take it without the WARN_ON_ONCE() calls
and note that in the commit message..

           Linus
