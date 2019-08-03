Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 520E380785
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfHCRq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 13:46:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34678 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbfHCRq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 13:46:58 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so47871358lfq.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/p+KPdle0DrLRp9FDoP7922eNS2fl3+QvM+XMS49p18=;
        b=SfAIEP8dYPvPxBXGvQBzqUS9lK22Y5MDsLVnm8uG4aK+sHOgyUCamno+GINWxdqYox
         8nP56Kmrezz8GMbb+krCpuO2OAGa7SarLxIt6fujzohWqRlBdyC8WVFvnZaITEJHRhl0
         Bo0ewzFOwjQdmm1f+brtrHDR/gGM2HxyYU5/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/p+KPdle0DrLRp9FDoP7922eNS2fl3+QvM+XMS49p18=;
        b=pTtdn2R89nhzSzlrvztdnTLLlLxPoe8rmuF4ST2LAZsZ8nnX8hvAPK7OeA4HxT2NFu
         Gfu/2PWPODKSFcVlWGxcZNUxLRlGRVJXiBbQKv8NNsSwsCZzOwSWvWuXVZqc0O3GwAqo
         Gi16AS2xmhGTHyrVNEpkW+cLNyj+77ywx9xqS0cY6R5hjVY2IIPPKMOB2UrjOFTZfU00
         OTvmMLH/Cez8IoWFSwF9dBB/XR970D4dUKuagzIeiryNIEyT5VZmgy1aiNnWrBALCNvc
         zdTuSFuNs119FynEznC+102VKwrjBaPLDz5uGql66BDo79mhU2DanuZ6MKRFXGqAO8Zi
         F/Gw==
X-Gm-Message-State: APjAAAUTxBIB4kSzjG66wzn6FC2EHokmeJ87WX2U2DTZ+FGLnPynIbQF
        Qv+zWHqcAz7Efj0iGu32oHb4skCIeAg=
X-Google-Smtp-Source: APXvYqyXotkXFmPWr1izJSwLnVCf7e1XiHbAvMMTapUBHx7xxJGvvm8k4n8HuGetdRnaYE9LkTKufQ==
X-Received: by 2002:ac2:44ce:: with SMTP id d14mr8634809lfm.143.1564854415885;
        Sat, 03 Aug 2019 10:46:55 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id w28sm15735261ljd.12.2019.08.03.10.46.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 10:46:55 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id c19so55098529lfm.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 10:46:54 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr65259782lfb.29.1564854414577;
 Sat, 03 Aug 2019 10:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190803163312.GK7138@magnolia>
In-Reply-To: <20190803163312.GK7138@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Aug 2019 10:46:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg8Y=KxZaHy66BdOKKtDzQ_XN4sR6YWa00+v+06azt4A@mail.gmail.com>
Message-ID: <CAHk-=wgg8Y=KxZaHy66BdOKKtDzQ_XN4sR6YWa00+v+06azt4A@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: cleanups for 5.3-rc3
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 3, 2019 at 9:33 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Here are a couple more bug fixes that trickled in since -rc1.  It's
> survived the usual xfstests runs and merges cleanly with this morning's
> master.  Please let me know if anything strange happens.

Hmm. This was tagged, but not signed like your usual tags are.

I've pulled it (I don't _require_ signed tags from kernel.org), but
would generally be much happier if I saw the signing too...

Thanks,

                 Linus
