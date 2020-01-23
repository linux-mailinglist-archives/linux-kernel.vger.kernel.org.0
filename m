Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4985146F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 18:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAWRXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 12:23:39 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:34824 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgAWRXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:23:39 -0500
Received: by mail-qt1-f171.google.com with SMTP id e12so3096868qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 09:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=+sYyfk2n+qS4NMdl3Vo9UqAuiI6xlOeTWYyIti0K5ik=;
        b=hVbeOddT0KKo6GOQuvzZWMbSjBYMK5i+gpoApDm7N88DDU9k7qb85keVm53gLSW8T7
         JDq9ygwaLv8amOGkNm5ietSMbJpDmIB80ktQL46tBNLbvAPcX4SbuDz/nQonbFTKozOH
         R86DkqlXkkhRzDZHQsyqUdUYq+eEDQDLlpl8OmErfsvZLow0aJ4ZTU3if869SL6nYL8/
         MaZ2T79MYU1wMk6rLDH7cHRZ7kzJNB9Z48iIIXkxKyhX0GaI1GDAsZF+v01IDSpBhtnN
         P34m0iFOBRgq98RAMpdKvR+6nYPh90rSmWfCpJTg52ZGVF5HGYW9qu+nmnbUXk7LiyCb
         lREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+sYyfk2n+qS4NMdl3Vo9UqAuiI6xlOeTWYyIti0K5ik=;
        b=EhP9rNXlePOE4cJi6wxxWEndmgzfjjeyaS02Uz+phWsy3g+7bNq7SvtbGUi1zocFyS
         OJq2uqfzZH8HU8nFkOWz6xZfnJbSEDM6q6c/Ennhgw3TGj5p/fV5+u4zF3kxtFTgwd/5
         JlCw5iUsdi/Jix/b7okIx6ZW+GHHJRbDvqATLwBC6ScTq3v4SVCa1qTGsDNpmSyVOKkl
         CO49/WbIh5nD6IVkO/9m0kR8DHbmfBnrsu9ShKyNTu4F8RyS4qNTVCgxYf0eupRptrcr
         ECHJGMfySSWBDEVEHpqzbxIqeuq0wf0Pk4oNcfuHAXCzNhmnSIKPLs/X/NF4FiHrY9ub
         /ewA==
X-Gm-Message-State: APjAAAXh5wIyT5kD6UrK2wztAoEprJk9nPWARUUGdEL5v2FnDCi9c5VR
        WIaLoB/ItyuaDd/4GqWKkfQRvUGvwW6ggQ==
X-Google-Smtp-Source: APXvYqwDs1vdseljV+3M82+Ba/lPWXbY6OUEEzKCzOwkCXHGV1a35jWIeymg/Y3S2CIuD8+ef/wZmQ==
X-Received: by 2002:aed:204d:: with SMTP id 71mr17284568qta.116.1579800217727;
        Thu, 23 Jan 2020 09:23:37 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g62sm1179038qkd.25.2020.01.23.09.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 09:23:37 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] arm64/spinlock: fix a -Wunused-function warning
Date:   Thu, 23 Jan 2020 12:23:36 -0500
Message-Id: <39F4C46F-6B94-4F0E-9CC6-1AB0BB5D6209@lca.pw>
References: <20200123165614.GA20126@willie-the-truck>
Cc:     peterz@infradead.org, longman@redhat.com, mingo@redhat.com,
        catalin.marinas@arm.com, clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200123165614.GA20126@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 23, 2020, at 11:56 AM, Will Deacon <will@kernel.org> wrote:
> 
> Damn, the whole point of this was to warn in the case that
> vcpu_is_preempted() does get defined for arm64. Can we force it to evaluate
> the macro argument instead (e.g. ({ (cpu), false; }) or something)?

That should work. Let me test it out and rinse.
