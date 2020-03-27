Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8530195467
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 10:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgC0Juc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 05:50:32 -0400
Received: from 8bytes.org ([81.169.241.247]:56190 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgC0Juc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:50:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9B4532C8; Fri, 27 Mar 2020 10:50:31 +0100 (CET)
Date:   Fri, 27 Mar 2020 10:50:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     iommu@lists.linux-foundation.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Lower severity of add/remove device messages
Message-ID: <20200327095029.GB11538@8bytes.org>
References: <20200323214956.30165-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323214956.30165-1-ezequiel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 06:49:56PM -0300, Ezequiel Garcia wrote:
> These user messages are not really informational,
> but mostly of debug nature. Lower their severity.

Like most other messages in the kernel log, that is not a reason to
lower the severity. These messages are the first thing to look at when
looking into IOMMU related issues.

Regards,

	Joerg

