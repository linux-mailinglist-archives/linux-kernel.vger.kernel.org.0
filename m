Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2F12A3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 19:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLXSe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 13:34:56 -0500
Received: from foss.arm.com ([217.140.110.172]:53804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfLXSe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 13:34:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB3371FB;
        Tue, 24 Dec 2019 10:34:55 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAC233F68F;
        Tue, 24 Dec 2019 10:34:54 -0800 (PST)
Date:   Tue, 24 Dec 2019 18:34:49 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     lukasz.luba@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, james.quinlan@broadcom.com, rostedt@goodmis.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 1/2] include: trace: Add SCMI header with trace events
Message-ID: <20191224183403.GA13926@bogus>
References: <20191217134345.14004-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217134345.14004-1-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:43:44PM +0000, lukasz.luba@arm.com wrote:
> From: Lukasz Luba <lukasz.luba@arm.com>
>
> Adding trace events would help to measure the speed of the communication
> channel. It can be also potentially used helpful during investigation
> of some issues platforms which use different transport layer.
>
> Update also MAINTAINERS file with information that the new trace events
> are maintained.
>

Applied both the patches for v5.6

--
Regards,
Sudeep
