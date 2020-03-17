Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E781879CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 07:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgCQGl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 02:41:59 -0400
Received: from foss.arm.com ([217.140.110.172]:32872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQGl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:41:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C89881FB;
        Mon, 16 Mar 2020 23:41:56 -0700 (PDT)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A38003F52E;
        Mon, 16 Mar 2020 23:45:55 -0700 (PDT)
Date:   Tue, 17 Mar 2020 06:41:52 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeffy Chen <jeffy.chen@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, anders.roxell@linaro.org,
        arnd@arndb.de, sboyd@kernel.org, gregkh@linuxfoundation.org,
        naresh.kamboju@linaro.org, daniel.lezcano@linaro.org,
        Basil.Eljuse@arm.com, mturquette@baylibre.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] arch_topology: Fix putting invalid cpu clk
Message-ID: <20200317064152.GB12791@e107533-lin.cambridge.arm.com>
References: <20200317063308.23209-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317063308.23209-1-jeffy.chen@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:33:08PM +0800, Jeffy Chen wrote:
> Add a sanity check before putting the cpu clk.
> 
> Fixes: b8fe128dad8f (“arch_topology: Adjust initial CPU capacities with current freq")


Interesting, I had NACKed the original patch in v1 IIRC.
I was against for adding clk into arch topology as not all platform
control CPUFreq via clk APIs. Anyways, as fix this makes sense, but
I need to take a look and find ways to remove it if possible, but that's
for some other time.

--
Regards,
Sudeep
