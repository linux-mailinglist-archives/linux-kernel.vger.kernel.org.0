Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4959F143463
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 00:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgATXLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 18:11:10 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43725 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgATXLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 18:11:09 -0500
Received: by mail-ot1-f47.google.com with SMTP id p8so1249484oth.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 15:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKP8yEJvIPRamm38nq6sQHvFo27I9jjAhAnyLSp8Eqk=;
        b=Y7HdRjx/0l6IwR2zYR/jo0+1FnpycOhLEVpMVNTtZkLwJUCKY6np7xTsU+u6u8IP9X
         P0Q9lyDZ8MNaE6lAPyw2S2GMfYSBxUG4U5aQJeW6mjlopDYDiKvnjsKC//2++5jBo4Lh
         5cBvbbhmCLO71b6SPdHmQsNgPfQHfanCnji+xABCuJdiPWk9glXGjiXPR5SmorQPAWQi
         PFdJ8VY2/jFlrqhLgsuhGYuUYbKZlsvT9xXVIYvrRw1QsD0Cx1INkCRAmVgYC/4+nXm1
         OGqRp8TIZ/jeNLfUxmp5R4xXJfrjoSrykSYH9MKHGnHLj2DhTa5BTHJkin7iczp03Cpp
         TnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKP8yEJvIPRamm38nq6sQHvFo27I9jjAhAnyLSp8Eqk=;
        b=TOEPsNou1NU0ryVlw8mgiewLdQ0M3FC72ElFiwwoPhHkLvBLfvqu83V9J6Vr1Gh3/X
         GUonO+5PgZCJbUiQ5UpX9ekTc8bOjMvf1SqqTyQEl7Ru+5SNmW/OllSJ7PqKZVUL20W3
         tLEFssC3CnXJybmyarnoDUye/4pZwjqKctRiqusE2Px1Hf1rIPl3UQWv0iyMq5OOF/26
         VrVBCn65T/2da3xgp2bFZ3sjwxNku7SEl0RGT3XiHAybKYrPhZAHUycEz7zIIf2e35bs
         +0UpmXDGqgIC6WJghj8eW1/vVYW9vGHQ9ITYwWMfcXTAo+Y4HcmWwqi7DmOLIEG3TBJk
         rZFw==
X-Gm-Message-State: APjAAAWdjJikV4ppgTYcUrJXYEqyczL/F0Gx9VeJQ6yzoIiqqRYb8mDJ
        BmGXAZ/zEThiER9QoGLsok5DmuhozkkoPpzJc2vrk6JH2W8=
X-Google-Smtp-Source: APXvYqxxBZWfhkjN4YVm5NI7lG9BUUPEcKfenADjWPC3pOFkvl0dIBsvoXwj1dFzaaYrU70ZrtlGQ7wrF28XJJq66AQ=
X-Received: by 2002:a9d:da2:: with SMTP id 31mr1326815ots.319.1579561868762;
 Mon, 20 Jan 2020 15:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 20 Jan 2020 15:10:57 -0800
Message-ID: <CAM_iQpWw9udHY5A2Gaq7+2WN__SEY2+U12D78=fiJ2xig1HJBA@mail.gmail.com>
Subject: Re: [Patch v3 0/3] iommu: reduce spinlock contention on fast path
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 8:40 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> This patchset contains three small optimizations for the global spinlock
> contention in IOVA cache. Our memcache perf test shows this reduced its
> p999 latency down by 45% on AMD when IOMMU is enabled.
>
> (Resending v3 on Joerg's request.)

Hi, Joerg

Can you take these patches?

Thanks!
