Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FA33AB2A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfFISkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 14:40:22 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:58388 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbfFISkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 14:40:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id 0BA6413D02E3;
        Sun,  9 Jun 2019 20:40:20 +0200 (CEST)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PVHEsyn7Y6u4; Sun,  9 Jun 2019 20:40:18 +0200 (CEST)
Received: from probook (x4db417da.dyn.telefonica.de [77.180.23.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Sun,  9 Jun 2019 20:40:18 +0200 (CEST)
Date:   Sun, 9 Jun 2019 20:40:13 +0200
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Klaus Kusche <klaus.kusche@computerix.info>
Cc:     keescook@chromium.org, bp@suse.de, samitolvanen@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/build: Move _etext to actual end of .text
Message-ID: <20190609184013.GA11237@probook>
References: <502d5b36-e0d0-ffcc-5dd4-35db9d033561@computerix.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <502d5b36-e0d0-ffcc-5dd4-35db9d033561@computerix.info>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019 Jun 09, Klaus Kusche wrote:
> 
> Hello,
> 
> Same problem for linux 5.1.7: 
> Kernel building fails with the same relocation error.
> 
> 5.1.5 does not have the problem, builds fine for me.
> 
> Is there anything I can do to investigate the problem?
> 

Please try linux 5.1.8. The problematic patch was reverted there.

-- 
Regards,
  Johannes

