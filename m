Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E0D187992
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 07:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgCQGYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 02:24:14 -0400
Received: from foss.arm.com ([217.140.110.172]:60996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQGYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:24:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D68841FB;
        Mon, 16 Mar 2020 23:24:13 -0700 (PDT)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B57633F52E;
        Mon, 16 Mar 2020 23:28:12 -0700 (PDT)
Date:   Tue, 17 Mar 2020 06:24:00 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeffy Chen <jeffy.chen@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, anders.roxell@linaro.org,
        arnd@arndb.de, sboyd@kernel.org, gregkh@linuxfoundation.org,
        naresh.kamboju@linaro.org, daniel.lezcano@linaro.org,
        Basil.Eljuse@arm.com, mturquette@baylibre.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] arch_topology: Fix putting invalid cpu clk
Message-ID: <20200317062348.GA12791@e107533-lin.cambridge.arm.com>
References: <20200317001829.29516-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317001829.29516-1-jeffy.chen@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 08:18:29AM +0800, Jeffy Chen wrote:
> Add a sanity check before putting the cpu clk.
> 
> Fixes: 2a6d1c6bcd1f (“arch_topology: Adjust initial CPU capacities with current freq")

Fixing a non-existent commit ?

--
Regards,
Sudeep
