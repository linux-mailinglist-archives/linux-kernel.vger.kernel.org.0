Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A11E7D4536
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 18:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfJKQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 12:19:01 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:39908 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfJKQTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:19:00 -0400
Received: from [167.98.27.226] (helo=[10.35.5.173])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iIxd5-0001df-EW; Fri, 11 Oct 2019 17:18:59 +0100
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Subject: sparse warnings on undeclared asmlinkage
Organization: Codethink Limited.
Message-ID: <67799c6b-77c1-8488-9595-38ca734e8d5f@codethink.co.uk>
Date:   Fri, 11 Oct 2019 17:18:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was reviewing the sparse output for the current kernel release and
note there are a number of warnings about un-declared functions which
are only used for code in assembly.

I was wondering if we should just ignore those, and have either a
new attribute for "undeclared is ok" or to make spare just ignore
anything with the syscall_linkage attribute?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
