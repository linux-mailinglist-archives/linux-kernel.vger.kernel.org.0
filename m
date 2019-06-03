Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3DC33B86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 00:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFCWnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 18:43:05 -0400
Received: from namei.org ([65.99.196.166]:36574 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfFCWnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:43:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x53MgpIv017414;
        Mon, 3 Jun 2019 22:42:51 GMT
Date:   Tue, 4 Jun 2019 08:42:51 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     viro@zeniv.linux.org.uk, stable@vger.kernel.org,
        Jose Bollo <jose.bollo@iot.bzh>,
        Casey Schaufler <casey@schaufler-ca.com>,
        torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Smack: Restore the smackfsdef mount option and add
 missing prefixes
In-Reply-To: <17467.1559300202@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1906040842110.13657@namei.org>
References: <155930001303.17253.2447519598157285098.stgit@warthog.procyon.org.uk> <17467.1559300202@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019, David Howells wrote:

> Should this go via Al's tree, James's tree, Casey's tree or directly to Linus?

If it's specific to one LSM (as this is), via Casey, who can decide to 
forward to Al or Linus.


-- 
James Morris
<jmorris@namei.org>

