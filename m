Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5406ABDB0D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfIYJdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 05:33:51 -0400
Received: from wolff.to ([98.103.208.27]:60726 "HELO wolff.to"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727387AbfIYJdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:33:11 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Sep 2019 05:33:11 EDT
Received: (qmail 10010 invoked by uid 500); 25 Sep 2019 09:17:00 -0000
Date:   Wed, 25 Sep 2019 04:17:00 -0500
From:   Bruno Wolff III <bruno@wolff.to>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     WireGuard mailing list <wireguard@lists.zx2c4.com>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: WireGuard to port to existing Crypto API
Message-ID: <20190925091700.GA9970@wolff.to>
References: <CAHmME9pmfZAp5zd9BDLFc2fWUhtzZcjYZc2atTPTyNFFmEdHLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHmME9pmfZAp5zd9BDLFc2fWUhtzZcjYZc2atTPTyNFFmEdHLg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Are there going to be two branches, one for using the current API and one 
using Zinc?
