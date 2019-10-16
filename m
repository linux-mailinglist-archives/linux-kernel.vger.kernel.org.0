Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7CD8983
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 09:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfJPHeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 03:34:08 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:38750 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfJPHeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:34:08 -0400
Received: from [167.98.27.226] (helo=[10.35.5.173])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKdot-0006Xm-1h; Wed, 16 Oct 2019 08:34:07 +0100
Subject: Re: [PATCH] bus: moxtet: declare moxtet_bus_type
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@lists.codethink.co.uk,
        Marek Behun <marek.behun@nic.cz>, linux-kernel@vger.kernel.org
References: <20191015122535.5439-1-ben.dooks@codethink.co.uk>
 <20191015163205.GB11160@infradead.org>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <ec914ca4-53c6-ef4d-b0db-82852cdd9bbe@codethink.co.uk>
Date:   Wed, 16 Oct 2019 08:34:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015163205.GB11160@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2019 17:32, Christoph Hellwig wrote:
> On Tue, Oct 15, 2019 at 01:25:35PM +0100, Ben Dooks wrote:
>> The moxtet_bus_type object is exported from the bus
>> driver, but not declared. Add a declaration for use
>> and to silence the following warning:
> 
> The symbol can be marked static instead.

Then it would have to be un-exported as it's listed as
EXPORT_SYMBOL_GPL(moxtet_bus_type);



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
