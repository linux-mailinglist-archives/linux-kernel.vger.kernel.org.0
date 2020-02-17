Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09ED016132D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 14:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgBQNVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 08:21:37 -0500
Received: from verein.lst.de ([213.95.11.211]:33789 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgBQNVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:21:37 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id F29F168B05; Mon, 17 Feb 2020 14:21:33 +0100 (CET)
Date:   Mon, 17 Feb 2020 14:21:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Roger Quadros <rogerq@ti.com>, Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Anna, Suman" <s-anna@ti.com>,
        stefan.wahren@i2se.com, afaerber@suse.de, hverkuil@xs4all.nl,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: Re: dma_mask limited to 32-bits with OF platform device
Message-ID: <20200217132133.GA27134@lst.de>
References: <c1c75923-3094-d3fc-fe8e-ee44f17b1a0a@ti.com> <3a91f306-f544-a63c-dfe2-7eae7b32bcca@arm.com> <56314192-f3c6-70c5-6b9a-3d580311c326@ti.com> <9bd83815-6f54-2efb-9398-42064f73ab1c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bd83815-6f54-2efb-9398-42064f73ab1c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roger,

can you try the branch below and check if that helps?

    git://git.infradead.org/users/hch/misc.git arm-dma-bus-limit

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/arm-dma-bus-limit
