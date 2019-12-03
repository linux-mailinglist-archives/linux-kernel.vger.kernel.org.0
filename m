Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 798431104FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 20:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfLCTYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 14:24:20 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:35583 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfLCTYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:24:20 -0500
Received: by mail-pf1-f182.google.com with SMTP id b19so2336915pfo.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 11:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btOlldos8WFYdKaeewOwOdI3rq74DAS7pkARWxi9A5s=;
        b=k7MRCPKuhValFSnpnJFhr3qxrS4tnqIqWHOQ5RBtDLudcXFqWXGOA2FJn5qJkXA2+3
         YOsUwf2rpDBAa9QfQbKOs6+Zi8Vp5aNKF0mNFFJHgL77UWWR0iiB+6qbq+ybFcfarbWi
         eZwLXaberoiLcpOtSjXLjeZEOViITcAa8P7g9BXU0H6zyvRCcfp/jyvjvEdKjkBLvuA+
         qTvZN5A4jhNYXPs0DJxSo8Zcf/62EC2E36907QRQ72X4t2bLJFWFKtJXqbkLnLMnnIiV
         uMHsc6uJMxltaY7+e4zHUDI0U6yszNzkhNl2Fssa3Q1E2eX6zxxrwYxVw3+lNN5Mri5U
         8REA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btOlldos8WFYdKaeewOwOdI3rq74DAS7pkARWxi9A5s=;
        b=GEhxsVIi1BLGKFQaLAvlTiFIsNMDwjgQuCJi+yMSvLXAbFthdaWnTsPcRRkVh0PDdS
         VhAgegiAzSDhGCtnPGKDRey0SIciBUHHWPTUJWU7WYccJyZdHrq+DPcxP3lkyOZqhWAC
         FmL01X6ofypTYdmwuN9kvZH1qm5uwLRfIRS2fJpsffIHaiST+mPDfXkTUJrPLy9WtISM
         3m1vTUjvVHSNI57Gwnee7kIcifl0NnjUmQM7DKWdLyHM75nVMdZxioKkRxIPLbhXvy3D
         eNyvcdizaO4zpM8A/Zs6hOOZc86WtitXfqk5x8nrC6diDj2UFbsPYe1ZVTOBJHare7ql
         Hq3w==
X-Gm-Message-State: APjAAAWYjqHli9hPI0AsF2xfLUQOh6oCFeypDHN9Zu5MLqg6DFu+/sox
        aVr0rugkk1tohmlUemsttjds8f20x95LlPvfa7bDOKEJVQY=
X-Google-Smtp-Source: APXvYqwwZ2d7i2kNu+/p5vwWPP71Po5t2EgQq5w9abaP14dGPYXXOmoABPJJNdR17gRnOO5ObNzkP+sOadAT6LHnKB0=
X-Received: by 2002:a62:d415:: with SMTP id a21mr6405803pfh.242.1575401059282;
 Tue, 03 Dec 2019 11:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-2-xiyou.wangcong@gmail.com> <20191202165847.GA30032@infradead.org>
In-Reply-To: <20191202165847.GA30032@infradead.org>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 3 Dec 2019 11:24:08 -0800
Message-ID: <CAM_iQpUy2t5zUBpyrMV8rSgVpeKSqheGG_yNOF15dKxBcRiFwg@mail.gmail.com>
Subject: Re: [Patch v2 1/3] iommu: match the original algorithm
To:     Christoph Hellwig <hch@infradead.org>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 8:58 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> I think a subject line better describes what you change, no that
> it matches an original algorithm.  The fact that the fix matches
> the original algorithm can go somewhere towards the commit log,
> preferably with a reference to the actual paper.

Ok, I will change subject to "iommu: avoid unnecessary magazine allocations".

And I will put the title of the paper in the commit log even though
it is already in the code comment.

Thanks.
