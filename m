Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0B48B7E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 14:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfHMME5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 08:04:57 -0400
Received: from muru.com ([72.249.23.125]:57270 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfHMME5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:04:57 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5517E8179;
        Tue, 13 Aug 2019 12:05:24 +0000 (UTC)
Date:   Tue, 13 Aug 2019 05:04:53 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, t-kristo@ti.com,
        d-gerlach@ti.com, dan.carpenter@oracle.com
Subject: Re: [PATCH] soc: ti: pm33xx: Fix static checker warnings
Message-ID: <20190813120453.GW52127@atomide.com>
References: <20190626075014.2911-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626075014.2911-1-j-keerthy@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190626 00:50]:
> The patch fixes a bunch of static checker warnings.

Sorry I just noticed that this one is still pending, applying
into fixes.

Tony
