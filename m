Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61FF6C9918
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 09:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfJCHlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 03:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfJCHlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:41:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0B0820873;
        Thu,  3 Oct 2019 07:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570088482;
        bh=L5t/2/pM7csmNlK5vE2ZgW7sWb2o73UBRKM7rDIbdNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VomR1vITC9UurWPaxDpqDCHgZTZ3FCxpnNdjN6jR1rPyKh1bSXFTPXtkYfCUNGedk
         B2ZS1icIppuzCvPfPhNYJ9F0Bj2ttZnRN6sv/rrBSdY/n89RSu1yiU2uzGAg6q4wIS
         PQ8Nao8uSloV197hSCPVq4HBEz2S5S2WyJAwHEes=
Date:   Thu, 3 Oct 2019 09:41:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-5.3.y] Versions in stable.git and stable-rc.git
Message-ID: <20191003074119.GA1815771@kroah.com>
References: <CA+icZUW9wrOAtEEXUNjHetq238D86c9c_Cf0iKQGiD+CH5bJrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUW9wrOAtEEXUNjHetq238D86c9c_Cf0iKQGiD+CH5bJrg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 09:38:27AM +0200, Sedat Dilek wrote:
> Hi Greg,
> 
> I see two commits with "Linux 5.3.2" - in [1] it is tagged but there
> is a second one in [2] - both in stable.git.
> 
> In stable-rc.git I see a commit "Linux 5.3.4-rc1" and there was no
> v5.3.3 released before.
> 
> Can you look at this?

Known issue, please see the announcement I made where I messed this all
up:
	https://lore.kernel.org/lkml/20191001070738.GC2893807@kroah.com/

thanks,

greg k-h
