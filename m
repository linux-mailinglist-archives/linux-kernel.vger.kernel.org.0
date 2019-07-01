Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2737B12D6F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 14:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfECMUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 08:20:55 -0400
Received: from verein.lst.de ([213.95.11.211]:37354 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfECMUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:20:54 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0A1DA68B05; Fri,  3 May 2019 14:20:36 +0200 (CEST)
Date:   Fri, 3 May 2019 14:20:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 0/4] nvme-pci: support device coredump
Message-ID: <20190503122035.GA21501@lst.de>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com> <20190502125722.GA28470@localhost.localdomain> <CAC5umygdADGrYeJy=F53Mm4bNPHmo+WY4SD3HFSRqi_cLrz9jw@mail.gmail.com> <20190503121232.GB30013@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503121232.GB30013@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 06:12:32AM -0600, Keith Busch wrote:
> Could you actually explain how the rest is useful? I personally have
> never encountered an issue where knowing these values would have helped:
> every device timeout always needed device specific internal firmware
> logs in my experience.

Yes.  Also not that NVMe now has the 'device initiated telemetry'
feauture, which is just a wired name for device coredump.  Wiring that
up so that we can easily provide that data to the device vendor would
actually be pretty useful.
