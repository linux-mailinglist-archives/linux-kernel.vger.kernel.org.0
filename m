Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97897D9C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 12:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfHAK72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 06:59:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36516 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfHAK72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:59:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8EC6C28C327
Subject: Re: [PATCH v4] platform/chrome: cros_ec_trace: update generating
 script
To:     Tzung-Bi Shih <tzungbi@google.com>, bleung@chromium.org,
        groeck@chromium.org, rrangel@chromium.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Dylan Reid <dgreid@google.com>
References: <20190730134704.44515-1-tzungbi@google.com>
 <CA+Px+wXetT1mQZW+3zc2vNDP4Jf3zKqGNz=Hq0yHn0Fvf=y-FQ@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <106711f8-117a-d0df-9b66-dc6be6431d07@collabora.com>
Date:   Thu, 1 Aug 2019 12:59:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+Px+wXetT1mQZW+3zc2vNDP4Jf3zKqGNz=Hq0yHn0Fvf=y-FQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi

On 30/7/19 16:07, Tzung-Bi Shih wrote:
> Hi Enric,
> 
> I found it is error-prone to replace the EC_CMDS after updated.
> Perhaps, we should introduce an intermediate file "cros_ec_trace.inc".

I am not sure I get you here, a .inc? could you explain a bit more?

Thanks,
~ Enric

> The generating script replaces whole ".inc" file every time and the
> cros_ec_trace.c includes the "cros_ec_trace.inc".
> 
> If this proposal makes sense to you, I can send the patch after this
> change landed for*-next.
> 
