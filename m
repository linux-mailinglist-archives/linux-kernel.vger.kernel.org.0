Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD2EF494B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 00:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfFQWBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 18:01:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37739 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfFQWBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:01:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id 131so10914067ljf.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsWdsGdHcCmWS5nc++DZu7iYbolrJmLe83td+Ig9vaE=;
        b=yuWRKTDlK+XqWjq7QVlSItRs/dXUKXy1A8l3JjvZDzMpjItd4K3XndJGD4EYZk89dH
         ftrGFYjxe/x+W0J4EENOQisBCGxAwZ74knvZTRRAdc95RzUE9ZqN7rle2lcHExq1+7+d
         KNKVUjO1/Tq7NCsuoyRpvvkXWShHtHahsZfcDYzKLOg/fIryjzvvFvVDPfhLU3/5KH1y
         5XpSd5sD9vfVqdAAPfRO+haO4Iyy2q/gOCkrVTjDr6Dwp+wLbDg3Ed7Ml30TrT1443Pg
         n+L8c/D2Ni7oRRnHXfPjEJBiwUCTC5tLd2F6dwMPu0LhLviEmx1CX74t2z/9l/sAASI7
         WMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsWdsGdHcCmWS5nc++DZu7iYbolrJmLe83td+Ig9vaE=;
        b=a6rbnoG7xuEv03MoUfYITSsxFueS4F65L6FgfrcDa0KCSywjc7DDKiJZRNjQt3gQCF
         MNY06BXBRlaJlmB+o8zx3o5d5oIs/gDmQbdLH357B+N8vrTlUCSH6oPV4I/8MP8hcL/o
         LegUdAZ2BeTHXiJ2QP1oA7F6iaZWs532XcTmhO2xrj8UIL4G60kAl8EV8iH5KDlnAP3a
         c6fBuEsKrb+qM+uoqKOr0XlBrzrtklTd9FHcBRIM80zLgzxsGLCOIwaFRXC49OJ44hCT
         Q/Krl/E5Z9y/6kDdAMswgEI0d/oS5VbCOnGrM72YBR156JPQazkZdx4jdG8d/uEqrx2x
         rwYA==
X-Gm-Message-State: APjAAAVRJzPC6Yk4LfcvHQrj1uD5TcbOZixySR490yKUntQFICSt6YcD
        ZXuc/W0SxntIlFs0kyJmHt5zCnSs+Suh2cvvKDc1
X-Google-Smtp-Source: APXvYqxO80PFS2J7nH7z2/60Uxxt+c0vds1wc/30QCv3aD8rM/v8/T8bRZyfd3RubIYEKJbFyWNOStsHG2Y6SBEYbYI=
X-Received: by 2002:a2e:9dc1:: with SMTP id x1mr617238ljj.0.1560808909485;
 Mon, 17 Jun 2019 15:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <53af233d05da5e07d75d122878387288a10276df.1560447640.git.rgb@redhat.com>
In-Reply-To: <53af233d05da5e07d75d122878387288a10276df.1560447640.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Jun 2019 18:01:38 -0400
Message-ID: <CAHC9VhQ5xgV2hnegThALdCP8KcqTLZsf2w6h2aT1WnH=-AdtEA@mail.gmail.com>
Subject: Re: [PATCH ghak57 V1] selinux: format all invalid context as untrusted
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacec <omosnace@redhat.com>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 2:43 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> All instances of one field type should be encoded in the same way.
> Since some invalid_context fields can contain untrusted strings, encode
> all instances of this field the same way.
>
> Please see github issue
> https://github.com/linux-audit/audit-kernel/issues/57

It would be good to see a list of all the places we are using the
"invalid_context" field and some discussion about if those labels are
really "trusted" or "untrusted".  In both the
compute_sid_handle_invalid_context() and security_sid_mls_copy() cases
below it would appear that the labels can be considered "trusted",
even if they are invalid.  I understand your concern about logging
consistency with the "invalid_context" field, but without some further
discussion it is hard to accept this patch as-is.

-- 
paul moore
www.paul-moore.com
