Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A55225BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 04:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfEVClA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 22:41:00 -0400
Received: from namei.org ([65.99.196.166]:33694 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfEVClA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 22:41:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4M2et1w006403;
        Wed, 22 May 2019 02:40:55 GMT
Date:   Wed, 22 May 2019 12:40:55 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC] Turn lockdown into an LSM
In-Reply-To: <20190521224013.3782-1-matthewgarrett@google.com>
Message-ID: <alpine.LRH.2.21.1905221203070.3967@namei.org>
References: <20190521224013.3782-1-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Matthew Garrett wrote:

> Hi James,
> 
> This is a quick attempt to integrate lockdown into the existing LSM
> framework. It adds a new lockdown security hook and an LSM that defines
> the existing coarse-grained policy, and also adds a new
> DEFINE_EARLY_LSM() definition in order to permit lockdown (and
> potentially other modules) to be initialised at the top of kernel init
> in order to allow policy to be imposed on stuff that happens in
> setup_arch(). The goal here is to allow policy to be devolved to other
> LSMs on systems that have a secure mechanism for loading LSM policy
> early in boot, allowing creation of arbitrarily complicated policies
> without interfering with the common-case coarse-grained approach.
> 
> This should probably be extended so a uapi-exposed constant is passed to
> the hook in order to make it easier to write policy in other LSMs, but
> does this broadly look like you were imagining?

This looks promising!

An LSM could also potentially implement its own policy for the hook.

-- 
James Morris
<jmorris@namei.org>

