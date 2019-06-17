Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5174795C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 06:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfFQE1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 00:27:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36610 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfFQE1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 00:27:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so9231489qtl.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 21:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jbyq7Q2frV79XYaBb+RkixOf6rqvbIp5HPcBcMU9Ye0=;
        b=jVpb4eWygwk/ckbAnoKWWrEL8/9ciuMeXo+OXMQbw4lVohXTa2QFT9iPZ22RMmTuG2
         kFzfBgluct1Lij+sA5G/Cky2Psq9/psI9HP6gEWqczMKh4QYF95VTgpFZ2FL/3KNHrKX
         iE1OChVEgj5cNjyyGmbEZaUswSIhsr6p5eNjtkg99/6I+WGhkqc3TZ3hw+0+EIqnugVQ
         DDeLGCkBaKM1E7JQzDEanIRZ27cv6hKXYyOuuox8efU5S1Xny/VbQCBRk06kDC1/LcFq
         uN/eO1YaOGrb/elEj/xB4/gLbSV78HD2r14HLRGsLTWrOCnjyb/SC7Dab4+Vj2tlvbKF
         D9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jbyq7Q2frV79XYaBb+RkixOf6rqvbIp5HPcBcMU9Ye0=;
        b=d56a+MByo9IS/1oDmCxSsoEl0AbYrZ3QGCxnz7dEv7kY1j9zFK8528A8lkQ+UaHiUq
         49d54tEMG6Cit302VaFvwo2yYXrx/tjWIaG/P123MFQGiCEGzUJZV3DC+4oZvsvSg/Fm
         3JCBKb+irK5IvzF7V/HG3P/SG5BnYbgo/0nKiEpXPjKI4wXTjI1bvwnpGDnYhs14B1zI
         J7XnFIm6Mx5nxXoUgtn5rlFatf+RYXiU7acW+XhxUaBq7Nw55m/4vol9+hpHvqXchAba
         3Rqqg6jYDbPkwo6xMu9bYlRAxws17CtetOOjkD6oLuDafkPt6Ff2cMetgPaBsD3bF2qG
         2cbQ==
X-Gm-Message-State: APjAAAUuRpZUgkbxmAlZvPt6pXL0zjDB8zM4lcGahcLtd+OiQBrTmhgK
        A/Txxu73XRLoLmZZTjecePl1e5BvlNGjwiufvz8=
X-Google-Smtp-Source: APXvYqz98YOorzFY4+k5v0LreYOOqec8w5b+vRF+LffTx/HLtStoJ/Aj3kJlMhu0loBjNZ2ykOkSKJhYWsW+jV1pTwE=
X-Received: by 2002:aed:3b66:: with SMTP id q35mr93395728qte.118.1560745641667;
 Sun, 16 Jun 2019 21:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190613175747.1964753-1-songliubraving@fb.com>
In-Reply-To: <20190613175747.1964753-1-songliubraving@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sun, 16 Jun 2019 21:27:10 -0700
Message-ID: <CAPhsuW6PEwRnw=z57LPLtsvZPVCcnZR69uhs5FRVczM2OZSeXA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] THP aware uprobe
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        matthew.wilcox@oracle.com, kirill.shutemov@linux.intel.com,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:58 AM Song Liu <songliubraving@fb.com> wrote:
>
> This set makes uprobe aware of THPs.
>
> Currently, when uprobe is attached to text on THP, the page is split by
> FOLL_SPLIT. As a result, uprobe eliminates the performance benefit of THP.
>
> This set makes uprobe THP-aware. Instead of FOLL_SPLIT, we introduces
> FOLL_SPLIT_PMD, which only split PMD for uprobe. After all uprobes within
> the THP are removed, the PTEs are regrouped into huge PMD.
>
> Note that, with uprobes attached, the process runs with PTEs for the huge
> page. The performance benefit of THP is recovered _after_ all uprobes on
> the huge page are detached.
>
> This set (plus a few THP patches) is also available at
>
>    https://github.com/liu-song-6/linux/tree/uprobe-thp
>
> Changes since v3:
> 1. Simplify FOLL_SPLIT_PMD case in follow_pmd_mask(), (Kirill A. Shutemov)
> 2. Fix try_collapse_huge_pmd() to match change in follow_pmd_mask().
>
> Changes since v2:
> 1. For FOLL_SPLIT_PMD, populated the page table in follow_pmd_mask().
> 2. Simplify logic in uprobe_write_opcode. (Oleg Nesterov)
> 3. Fix page refcount handling with FOLL_SPLIT_PMD.
> 4. Much more testing, together with THP on ext4 and btrfs (sending in
>    separate set).
> 5. Rebased up on Linus's tree:
>    commit 35110e38e6c5 ("Merge tag 'media/v5.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media")
>
> Changes since v1:
> 1. introduces FOLL_SPLIT_PMD, instead of modifying split_huge_pmd*();
> 2. reuse pages_identical() from ksm.c;
> 3. rewrite most of try_collapse_huge_pmd().
>

Hi Kirill and Oleg,

Does this version look good to you? If so, could you please reply with
your Acked-by and/or Reviewed-by?

Thanks,
Song
