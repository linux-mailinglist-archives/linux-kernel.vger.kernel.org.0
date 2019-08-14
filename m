Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D68D16E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 12:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfHNKtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 06:49:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:56840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727226AbfHNKto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:49:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0F0CADEF;
        Wed, 14 Aug 2019 10:49:43 +0000 (UTC)
Date:   Wed, 14 Aug 2019 12:49:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] printk: Replace strncmp with str_has_prefix
Message-ID: <20190814104941.qt66ozcau5fdswcs@pathway.suse.cz>
References: <20190809071034.17279-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809071034.17279-1-hslester96@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-08-09 15:10:34, Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone because len
> is easy to have typo.
> The example is the hard-coded len has counting error
> or sizeof(const) forgets - 1.
> So we prefer using newly introduced str_has_prefix()
> to substitute such strncmp to make code better.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
