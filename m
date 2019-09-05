Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B5AA97AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 02:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfIEAkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 20:40:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35559 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIEAkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:40:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id 100so419644otn.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 17:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OxSkqoSh+0HMVxSUeqDi0SoEqFfeyqeJm0b071hAlMc=;
        b=GOOIgAydwTEpRK2ZdTj4eZDpiSmni0FBcYW5siDWuc+gMvN5ZYahvytiku4Ht5oMlY
         gl3OGEN9sKy3u3QXUdgGMbiS6gYDUCLkiJ6q3BjMhjUzV/XgGW1yIX2PycokViLX887E
         IOcctW1TeTwXu7/uhikJCh5NGET1A38LkkPK6csSVDN/D8bIReD8yohlHchLvlizNH3D
         tP8VAI2E1gHs9Hft3AIV3mTL3lRVkANaAlVVf31WJMTQz7Ag1XOcwoVSG0AbMIQeCGoD
         PL06AcTyDDaM23v+NtXb8TFomlWkO8SH/jKAiHHWORsMCM7y1luqzJaPcBhgeoTBXPgF
         mYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxSkqoSh+0HMVxSUeqDi0SoEqFfeyqeJm0b071hAlMc=;
        b=CpLdaadbYyukps7jwexf1Cll4MgT+SS41VM7kE8thy4TeJmZtsa6s5U437DQmXFRAu
         6GCvuArHhlT/kqoU8JwtvdAA8GpcVEnzNxa73rtxrRSk/Vo+jbwN6uK+bIFZ1Rt91dTB
         2hnm3CiJ9EZNBZuYLGfMqWAf+ndS14pmRCV3lF9tsoR4UnuMdUfAXd65W/tJw2TUjf+O
         8pAPeAI74H1FZVqm6Q1u90A4Rg7r/NPtcDSw5kIy7wsC3Tnxnl9umv3XqervshzxkWLa
         WMCTTdWAVYGR/6Pm+xxC8XtjDIB11M9UJ36Tljr3eZBav2dF+skcTl9D2ZhchbCdVSQg
         zLhA==
X-Gm-Message-State: APjAAAVAjDq/2MQPh+XtoINOkr5p6GVHd7RHIi/waQnvvudKdiWLQecS
        IAaMrJksybYN2mWcTyV/M/zkhaYQzviLJrAK+gg=
X-Google-Smtp-Source: APXvYqwpWI27z+3wJ9vL6rM2vr1U09kEUHx4FuxLxEBZI6pcKzLchmXuVNPu6Ilu+wSjcguXf/HMFdkvfAocIQhPXes=
X-Received: by 2002:a05:6830:1e96:: with SMTP id n22mr285018otr.368.1567644038405;
 Wed, 04 Sep 2019 17:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190903160430.1368-1-lpf.vector@gmail.com> <0100016cfdbed786-8e9441ab-4c0c-4d2d-b9dc-d1d6878481b8-000000@email.amazonses.com>
In-Reply-To: <0100016cfdbed786-8e9441ab-4c0c-4d2d-b9dc-d1d6878481b8-000000@email.amazonses.com>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Thu, 5 Sep 2019 08:40:27 +0800
Message-ID: <CAD7_sbEM5KTLzWjEWB__jhK+NrzANnBnHK4=xM6Wq4V7ziF3_g@mail.gmail.com>
Subject: Re: [PATCH 0/5] mm, slab: Make kmalloc_info[] contain all types of names
To:     Christopher Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 3:27 AM Christopher Lameter <cl@linux.com> wrote:
>
> On Wed, 4 Sep 2019, Pengfei Li wrote:
>
> > There are three types of kmalloc, KMALLOC_NORMAL, KMALLOC_RECLAIM
> > and KMALLOC_DMA.
>
> I only got a few patches of this set. Can I see the complete patchset
> somewhere?

Yes, you can get the patches from
https://patchwork.kernel.org/cover/11128325/ or
https://lore.kernel.org/patchwork/cover/1123412/

Hope you like it :)
