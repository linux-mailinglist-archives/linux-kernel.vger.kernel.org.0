Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F5EB1C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 14:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfJaN7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 09:59:22 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35559 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfJaN7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:59:22 -0400
Received: by mail-yw1-f66.google.com with SMTP id r134so2154630ywg.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6lc72BgRwD53g5GkhGUqFFG2nhb0dXxx1JADtBs5rJw=;
        b=nd7hRbEAfWE8bai204exlUd4eQxE+PqtFpB4gNcChz18ASnUWtYBaJ7hq9VvRDL2Mt
         9J1qcpniYjzrbZZF76uQKP4yZ7l0m26a3Oi696396zqnYybZSMV4jbZWNYIc0TuOavVG
         coo19mZKcAn8G4QoLCo9pNivxwz3JdkdMXDLrDWI2KB4khoTwd0/B3TWA9ttzwc3vuUz
         JIejUDdHxuSCBhI7MZG2MFRCFX+OMIsoY7gepXTB/RhrmJeo31B4ELQ07NhPc5XmGo5E
         KW0So4p5uEzR946cLNcCBFQ2cLahz4wu4ihWFl7cq2CRQgiVgVSLPZcrcgjxBK/HL0QQ
         fJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lc72BgRwD53g5GkhGUqFFG2nhb0dXxx1JADtBs5rJw=;
        b=XeTbKfpsPVdKwysxgyu2yRE+qy5JOqGEECWYCnF4NK0W2KZ5nLvks2wb8/SPbZGHNR
         xKvq0isvCycRymoIqEfplYPVDSW18h/Rs5NG5RnMRSuLo75w1LhIxoklRKBYkTi1Pgk8
         YQ5xUgnoA307lc5HZmxXlEMHF2DSocZDTEi+nysy+KMkj9YSJ/AKKc1uWurmLmnphxi8
         5amhIfJ7FUbGWGxXNjxDwIpEnBbR4GGY6T4tmGaGYaEeHzQFSj8kOJ3BP79yCm6sddnR
         gGZImV6owyCaufeWifCXIk3EthRw4pViPWgftMtUq+TDZhNmPLBfeTbyThWxiEVe9ReY
         7nIw==
X-Gm-Message-State: APjAAAWHgRE0Z3hxAMwzkw1d3wWjvWG+F7CWSkb6s6i1Ip/Dqrca8phl
        vggXuYxdlM3u0hXsGsoTS2afzsFOlwbpNE2oCtw=
X-Google-Smtp-Source: APXvYqxnJjDho9Fs/2WI2ekNVqdpR61OXuGHmahrpf/DG4rRrgDRSb2F2w/896cjP6fYX7HUL+77E3xhip/EDSGoPcQ=
X-Received: by 2002:a81:61c3:: with SMTP id v186mr4332558ywb.151.1572530361617;
 Thu, 31 Oct 2019 06:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191031050338.12700-1-csm10495@gmail.com> <20191031133921.GA4763@lst.de>
In-Reply-To: <20191031133921.GA4763@lst.de>
From:   Charles Machalow <csm10495@gmail.com>
Date:   Thu, 31 Oct 2019 06:59:10 -0700
Message-ID: <CANSCoS-RzcutTWHN1t1iyW3GjqNcY5xFUZtJhAThDp5SPPrDAA@mail.gmail.com>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, marta.rybczynska@kalray.eu,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019, 6:39 AM Christoph Hellwig <hch@lst.de> wrote

> All that casting is a pretty bad idea.  please just add an explicit
> reserved field before the result, and check that it always is zero
> in the ioctl handler.

Not quite sure what you mean by check for zero in the ioctl handler. I
like the idea of being able to use the same struct for either the
original or 64 ioctls from userspace. I don't believe adding the
explicit rsvd field allows that

- Charlie Scott Machalow

On Thu, Oct 31, 2019 at 6:39 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Oct 30, 2019 at 10:03:38PM -0700, Charles Machalow wrote:
> > Changing nvme_passthru_cmd64's result field to be backwards compatible
> > with the nvme_passthru_cmd/nvme_admin_cmd struct in terms of the result
> > field. With this change the first 32 bits of result in either case
> > point to CQE DW0. This allows userspace tools to use the new structure
> > when using the old ADMIN/IO_CMD ioctls or new ADMIN/IO_CMD64 ioctls.
>
> All that casting is a pretty bad idea.  please just add an explicit
> reserved field before the result, and check that it always is zero
> in the ioctl handler.
