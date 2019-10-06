Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E029CD954
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 23:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfJFVbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 17:31:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57358 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfJFVbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 17:31:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHE7Q-0005Fd-Tt; Sun, 06 Oct 2019 21:31:09 +0000
Date:   Sun, 6 Oct 2019 22:31:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        olsonse@umich.edu, hsweeten@visionengravers.com, abbotti@mev.co.uk
Subject: Re: [PATCH] staging: comedi: Capitalize macro name to fix camelcase
 checkpatch warning
Message-ID: <20191006213108.GJ26530@ZenIV.linux.org.uk>
References: <20191006184903.12089-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006184903.12089-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 07:49:03PM +0100, Jules Irenge wrote:

[mA vs. MA]

Table 5.  SI prefixes
Factor	Name 	Symbol
....
10^6	mega	M
....
10^-3	milli	m

Confusing one for another (especially for electrical units) can be...
spectacular.  FYI, 1mA is more or less what you get if you lick
the terminals of a 9V battery; 1MA is about 30 times the current
in typical lightning strike...
