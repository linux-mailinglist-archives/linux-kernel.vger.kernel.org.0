Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9ABC000D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 09:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfI0HbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 03:31:14 -0400
Received: from mail.monom.org ([188.138.9.77]:57162 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfI0HbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:31:13 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 0C383500587;
        Fri, 27 Sep 2019 09:31:12 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (b9168f76.cgn.dg-w.de [185.22.143.118])
        by mail.monom.org (Postfix) with ESMTPSA id D5EBC500483;
        Fri, 27 Sep 2019 09:31:11 +0200 (CEST)
Date:   Fri, 27 Sep 2019 09:31:11 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     qla2xxx-upstream@qlogic.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Remove WARN_ON_ONCE in
 qla2x00_status_cont_entry()
Message-ID: <20190927073111.jm3jjmm5gcr6ylc7@beryllium.lan>
References: <20190926074637.77721-1-dwagner@suse.de>
 <5d5931ef-7ffa-3f3f-bb5e-5379c1716d04@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5931ef-7ffa-3f3f-bb5e-5379c1716d04@acm.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Should the following be added?
> 
> Fixes: 88263208dd23 ("scsi: qla2xxx: Complain if sp->done() is not
> called from the completion path")

Good point. Just send out and updated version

> Anyway:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks!
Daniel
