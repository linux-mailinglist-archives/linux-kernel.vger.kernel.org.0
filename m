Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1A117EDC8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 02:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCJBKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 21:10:51 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:44596 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgCJBKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 21:10:51 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id CDE1C803087C;
        Tue, 10 Mar 2020 01:10:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lLQjXrfy39ya; Tue, 10 Mar 2020 04:10:47 +0300 (MSK)
Date:   Tue, 10 Mar 2020 04:09:57 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/22] dt-bindings: Permit platform devices in the
 trivial-devices bindings
References: <20200306124705.6595-1-Sergey.Semin@baikalelectronics.ru>
 <20200306124823.38C2A80307C4@mail.baikalelectronics.ru>
 <20200306140550.0A68180307C4@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200306140550.0A68180307C4@mail.baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200310011048.CDE1C803087C@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 07:56:51AM -0600, Rob Herring wrote:
> On Fri, Mar 6, 2020 at 6:48 AM <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >
> > Indeed there are a log of trivial devices amongst platform controllers,
> > IP-blocks, etc. If they satisfy the trivial devices bindings requirements
> > like consisting of a compatible field, an address and possibly an interrupt
> > line why not having them in the generic trivial-devices bindings file?
> 
> NAK.
> 
> Do you have some documentation on what a platform bus is? Last I
> checked, that's a Linux thing.
> 
> If anything, we'd move toward getting rid of trivial-devices.yaml. For
> example, I'd like to start defining the node name which wouldn't work
> for trivial-devices.yaml unless we split by class.
> 
> Rob

Hello Rob,

Understood. I thought the trivial-devices bindings was to collect all
the devices with simple bindings, but it turns out to be a stub for
devices, which just aren't described by a dedicated bindings file.
I'll resubmit the v2 version with no changes to the trivial-devices.yaml,
but with CDMM/CPC dt-nodes having yaml-based bindings.

Regards,
-Sergey

