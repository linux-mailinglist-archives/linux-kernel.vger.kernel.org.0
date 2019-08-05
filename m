Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 444AA81D64
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 15:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfHENj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 09:39:56 -0400
Received: from foss.arm.com ([217.140.110.172]:49382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHENj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:39:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7872337;
        Mon,  5 Aug 2019 06:39:55 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E42FA3F706;
        Mon,  5 Aug 2019 06:39:54 -0700 (PDT)
Date:   Mon, 5 Aug 2019 14:39:48 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Tri Vo <trong@google.com>, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ARM: UNWINDER_FRAME_POINTER implementation for Clang
Message-ID: <20190805133940.GA10425@arm.com>
References: <20190801231046.105022-1-nhuck@google.com>
 <01222982-4206-9925-0482-639a79384451@arm.com>
 <CAJkfWY6StuyMuKG7XdEJrqMsA_Xy02QZKp8r0K2jwSZwBCt+9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJkfWY6StuyMuKG7XdEJrqMsA_Xy02QZKp8r0K2jwSZwBCt+9Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 10:27:30AM -0700, Nathan Huckleberry wrote:
> You're right. Would pushing an extra register be an adequate fix?

Would forcing CONFIG_ARM_UNWIND=y for clang work as an alternative to
this?

Assuming clang supports -funwind-tables or equivalent, this may just
work.

[...]

Cheers
---Dave
